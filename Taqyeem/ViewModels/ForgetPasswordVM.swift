//
//  ForgetPasswordVM.swift
//  Taqyeem
//
//  Created by mac on 1/8/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct ForgetPasswordVM {
    static func getPasswordCode(mobile :String , completion: @escaping (_ user: AuthenricationVM?, _ error: String?) -> Void) {

          var request = URLRequest(url: URL(string: "http://healthctrl.qassim.gov.sa:8008/rating_app/user/reset_password")!)
                 request.httpMethod = HTTPMethod.post.rawValue
                 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                 let paramString = "{\"mobile\" : \(mobile)}"
                 request.httpBody = paramString.data(using: .utf8)
                 Alamofire.request(request).responseJSON { (response) in
                     print(response)
                     if let statusCode = response.response?.statusCode {
                         if let res = response.result.value as? NSDictionary {
                             if statusCode >= 200 && statusCode < 300 {
                                 if let user: User = res.getObject() {
                                     completion(AuthenricationVM(user: user), nil)
                                 }
                             }else if statusCode == 401 {
                                 UserDefaultsAccess.sharedInstance.user = nil
                                 UIApplication.topViewController()?.stopLoadingActivity()
                                 UIApplication.topViewController()?.logOut()
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
    
    
    static func changePassword(newPassword :String ,userID :Int, completion: @escaping (_ success: Bool?, _ error: String?) -> Void) {
           var request = URLRequest(url: URL(string: "http://healthctrl.qassim.gov.sa:8008/rating_app/user/save")!)
                  request.httpMethod = HTTPMethod.post.rawValue
                  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                  let paramString =  "{\"id\" : \"\(userID)\",\"password\" : \"\(newPassword)\"}"
       
                  request.httpBody = paramString.data(using: .utf8)
                  Alamofire.request(request).responseJSON { (response) in
                      print(response)
                      if let statusCode = response.response?.statusCode {
                              if statusCode >= 200 && statusCode < 300 {
                               completion(true, nil)
                          }else if statusCode == 401 {
                              UserDefaultsAccess.sharedInstance.user = nil
                              UIApplication.topViewController()?.stopLoadingActivity()
                              UIApplication.topViewController()?.logOut()
                          } else {
                              completion(false, "Unable to get data")
                          }
                      
                  }
        }
    }
    
}
