//
//  ComplainTypeVM.swift
//  Taqyeem
//
//  Created by mac on 12/22/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct ComplainTypeVM {
var complain :ComplainType
    
    var compplaintypeId: Int {
           return complain.compplaintypeid ?? 0
       }
       
       var complainType: String {
           return complain.complaintype ?? ""
       }
    
 static func getAllComplainTypes(completion: @escaping (_ complains: [ComplainTypeVM]?, _ error: String?) -> Void) {
     var config = NetworkManager.Configuration(parameters: nil, url: .complains, method: .post)
     NetworkManager.makeRequest(configuration: config) {
         response in
         if let statusCode = response.response?.statusCode {
             if let res = response.result.value as? [NSDictionary] {
                 if statusCode >= 200 && statusCode < 300 {
                     if let complains: [ComplainType] = res.getObject() {
                         completion(complains.map {ComplainTypeVM(complain: $0) }, nil)
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
