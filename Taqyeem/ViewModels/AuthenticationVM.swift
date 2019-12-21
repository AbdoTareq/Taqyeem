//
//  AuthenticationVM.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/30/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct AuthenricationVM {
    var user: User
    var id: Int {
        return user.id ?? 0
    }
    var firstName: String {
        return user.firstName ?? ""
    }
    var lastName: String {
        return user.lastName ?? ""
    }
    var nickName: String {
       return user.nickName ?? ""
    }
    var email: String {
        return user.email ?? ""
    }
    var image: String {
        return user.image ?? ""
    }
    var token: String {
        return user.token ?? ""
    }
    var mobile: String {
       return user.mobile ?? ""
    }
    static func register(user: User, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/user/save")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"firstName\" : \"\(user.firstName ?? "")\", \"lastName\" : \"\(user.lastName ?? "")\", \"nickName\" : \"\(user.nickName ?? "")\", \"email\" : \"\(user.email ?? "")\", \"isBlackListed\" : \"\("0")\", \"isDeleted\" : \"\(0)\", \"mobile\" : \"\(user.mobile ?? "")\", \"password\" : \"\(user.password ?? "")\", \"isAdmin\" : \"\(0)\"}"
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
    static func login(mobile: String, password: String, completion: @escaping (_ user: AuthenricationVM?, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/user/authenticate")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"mobile\" : \"\(mobile)\", \"token\" : \"\(password)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? NSDictionary {
                    if statusCode >= 200 && statusCode < 300 {
                        if let user: User = res.getObject() {
                            completion(AuthenricationVM(user: user), nil)
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
    
    
    static func update(user: User, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
          var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/user/save")!)
          request.httpMethod = HTTPMethod.post.rawValue
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"firstName\" : \"\(user.firstName ?? "")\", \"lastName\" : \"\(user.lastName ?? "")\", \"nickName\" : \"\(user.nickName ?? "")\", \"email\" : \"\(user.email ?? "")\", \"isBlackListed\" : \"\("0")\", \"isDeleted\" : \"\(0)\", \"mobile\" : \"\(user.mobile ?? "")\", \"password\" : \"\(user.password ?? "")\", \"isAdmin\" : \"\(0)\" ,  \"id\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\"}"
          request.httpBody = paramString.data(using: .utf8)
    
          Alamofire.request(request).responseJSON { (response) in
              if let statusCode = response.response?.statusCode {
                  if statusCode == 201 {
                      completion(true, nil)
                  } else {
                      completion(false, "\(statusCode) - Unable to update profile")
                  }
              }
          }
      }
    
}
