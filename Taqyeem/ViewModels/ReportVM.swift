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
    
    var id: Int {
        return report.id ?? 0
    }
    
    var complaininformername: String {
        return report.complaininformername ?? ""
    }
    
    var complaintext: String {
        return report.complaintext ?? ""
    }
    var storename: String {
        return report.storename ?? ""
    }
    var mobile: Int {
        return report.mobile ?? 0
    }
    var user: User {
        return report.mobileuser ?? User()
    }
    var complainDate: String {
        return report.complaindate ?? ""
    }
    
    static func getMyReports(completion: @escaping (_ users: [ReportVM]?, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/comp/by_userid")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var userdic2 = "{\"id\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\"}"
        let paramString = "{\"mobileuser\" : \(userdic2)}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let resturants: [Report] = res.getObject() {
                            completion(resturants.map { ReportVM(report: $0) }, nil)
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
        guard let user = UserDefaultsAccess.sharedInstance.user, let id = user.id else {
            completion(false, "You must login")
            return
        }
        
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
    static func submitBug(issuesDescription :String ,date:String, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        guard let user = UserDefaultsAccess.sharedInstance.user, let id = user.id else {
            completion(false, "You must login")
            return
        }
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/issue/save")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"dateTime\" : \"\(date)\", \"issuesDescription\" : \"\(issuesDescription)\", \"reportedBy\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            if let statusCode = response.response?.statusCode {
                if statusCode == 201 {
                    completion(true, nil)
                } else {
                    completion(false, "\(statusCode) - Unable to add bug")
                }
            }
        }
    }
    
}

