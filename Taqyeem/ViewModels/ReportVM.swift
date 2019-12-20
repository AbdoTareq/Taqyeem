//
//  ReportVM.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/4/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct ReportVM {
    var report: Report
    func getMyReports(completion: @escaping (_ users: [NewsVM]?, _ error: String?) -> Void) {
        var config = NetworkManager.Configuration(parameters: nil, url: .news, method: .get)
        config.urlParameters = "all"
        NetworkManager.makeRequest(configuration: config) {
            response in
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let news: [News] = res.getObject() {
                            completion(news.map { NewsVM(news: $0) }, nil)
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
    
    static func submitReport(complainInformation :String ,complainText:String,mobile:String,storename:String, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/comp/save")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var dic2 = "{\"compplaintypeid\" : \"\(2)\"}"
        var userdic2 = "{\"id\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\"}"
    let paramString = "{\"complaininformername\" : \"\(complainInformation)\", \"complaintext\" : \"\(complainText)\", \"compplaintype\" : \(dic2), \"mobile\" : \"\(mobile)\", \"storename\" : \"\(storename)\", \"mobileuser\" : \(userdic2)}"
    request.httpBody = paramString.data(using: .utf8)
    Alamofire.request(request).responseJSON { (response) in
        if let statusCode = response.response?.statusCode {
            if statusCode == 201 {
                completion(true, nil)
            } else {
                completion(false, "\(statusCode) - Unable to register")
            }
        }
        }
    }
}

