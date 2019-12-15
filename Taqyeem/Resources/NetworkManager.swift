import Alamofire
import Foundation
enum Environment {
    case dev
    case testing
    case prod
}
class NetworkManager {
    static var bURL = "http://46.151.210.248:8888/rating_app/"
    static func getUrl(service: ServiceBase) -> String {
        return "\(bURL)\(service.rawValue)"
    }
    struct Configuration {
        var parameters: [String: Any]?
        var urlParameters: String = ""
        var apiVersion: APIVersion? = .v1
        var url: ServiceBase
        var method: HTTPMethod
        var requestType: RequestType = .api
        var cache: Bool = false
        var urlString: String {
            let baseURL = apiVersion?.getURL() ?? ""
            return "\(baseURL)\(url.rawValue)\(urlParameters.isEmpty ? "" : "/" + urlParameters)"
        }
        
        enum APIVersion: String {
            case v1, v2

            func getURL() -> String {
                switch self {
                case .v1:
                    return (Configuration.environment == .prod) ? "http://46.151.210.248:8888/rating_app/" : "https://api-dev.reachplus.co/api/v1/"
                case .v2:
                    return (Configuration.environment == .prod) ? "https://api.reachplus.co/api/v2/" : "https://api-dev.reachplus.co/api/v2/"
                }
            }
        }
        static var environment: Environment = .prod
    }

    enum RequestType {
        case api
        case external
    }

    static var rawResponse: NSDictionary?

    private static let appVersion: String = {
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let build = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        return version + "B" + build
    }()

    static var headers: [String: String] {
        return [
            "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer \(UserDefaultsAccess.sharedInstance.token)",
                //"Content-language": L102Language.currentAppleLanguage().contains("ar") ? "ar" : "en",
                //"current-version": appVersion
        ]
    }

    class func makeRequest(configuration: Configuration, completion: @escaping (_ response: DataResponse<Any>) -> Void) {
        rawResponse = nil
        let serviceURL = configuration.urlString

        let unWrappedParameters = configuration.parameters ?? [String: Any]()

        Alamofire.SessionManager.default.session.configuration.requestCachePolicy = configuration.cache ? .returnCacheDataElseLoad : .useProtocolCachePolicy
        print(headers)
        Alamofire.request(
            serviceURL,
            method: configuration.method,
            parameters: unWrappedParameters,
            encoding: URLEncoding.default,
            // (method == .post ? JSONEncoding.default :
            headers: headers
        )

        //            .validate()
            .validate(contentType: ["application/json"])

        .responseJSON {
            response in
            print(response)
            debugPrint(response)

            if let data = response.request?.httpBody {
                print(String(data: data, encoding: .utf8) ?? "")
            }

            completion(response)
        }
    }

    private class func validateResponseForAPI<T: Decodable>(response: DataResponse<Any>) -> APIResponse<T> {
        switch response.result
        {
        case let .success(result):

            guard
                let JsonArray = result as? NSDictionary,
                var obj: APIResponse<T> = JsonArray.getObject()
            else {
                return APIResponse(sucess: false, message: "Unknown Error Code 38", data: nil)
            }
            rawResponse = JsonArray

            obj.sucess = (200 ... 300).contains(response.response?.statusCode ?? 0)
            if let error = parseError(JsonArray) {
                obj.message = error
            }

            if (response.response?.statusCode ?? 0) == 401
            {
                UserDefaultsAccess.sharedInstance.clearData()
                //(UIApplication.shared.delegate as! AppDelegate).decideRootView(animated: false)
            }

            return (obj)

        case let .failure(result):
            rawResponse = nil
            // Log
            print("Failure Response: \(result)")
            if let err = result as? URLError, err.code == .notConnectedToInternet {
                return (APIResponse(sucess: false, message: "No Internet", data: nil))
            }
            else {
                UserDefaultsAccess.sharedInstance.clearData()
                //(UIApplication.shared.delegate as! AppDelegate).decideRootView(animated: false)
                return (APIResponse(sucess: false, message: "Unknown Error Code 39", data: nil))
            }
        }
    }

    private class func parseError(_ rawResponse: NSDictionary) -> String? {
        guard let error = rawResponse["errors"] as? NSDictionary else { return nil }
        let firstElement = error.allValues.first as? [String]
        return firstElement?.first
    }

    static func download(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, progress _: ((_ progress: Progress) -> Void)?, completion: @escaping (_ response: Any?) -> Void) {
        Alamofire.request(
            url,
            method: method,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers
        ).responseData {
            response in

            if response.error == nil {
                completion(response.data)
            }
            else {
                completion(nil)
            }
        }
    }
}

extension NetworkManager.Configuration {
    init(parameters: [String: Any]?, url: ServiceBase, method: HTTPMethod) {
        self.url = url
        self.method = method
        self.parameters = parameters
    }
}

