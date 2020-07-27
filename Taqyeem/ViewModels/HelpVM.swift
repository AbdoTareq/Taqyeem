//
//  HelpVM.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/21/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct HelpVM {
    var help: Help
    var id: Int {
        return help.id ?? 0
    }
    var text: String {
        return help.text ?? ""
    }
    var isHeader: Int {
        return help.isHeader ?? 0
    }
    static func get(type: Int, completion: @escaping (_ contactUs: [HelpVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .help)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"type\" : \"\(type)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let help: [Help] = res.getObject() {
                            completion(help.map { HelpVM(help: $0) }, nil)
                        } else {
                         completion(nil, "Unable to get data")
                        }
                    } else {
                        completion(nil, "Unable to get data")
                    }
                } else {
                    completion(nil, "Unable to get data")
                }
            } else {
                completion(nil, "Unable to get data")
            }
        }
    }
}
