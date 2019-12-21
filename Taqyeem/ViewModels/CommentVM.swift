//
//  CommentVM.swift
//  Taqyeem
//
//  Created by mac on 12/15/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct CommentVM {
    var comment :Comment
    static func getAllComments(storeID : Int,completion: @escaping (_ comments: [CommentVM]?, _ error: String?) -> Void) {
          let url = NetworkManager.getUrl(service: .ratingAndComments)
             var request = URLRequest(url: URL(string: url)!)
             request.httpMethod = HTTPMethod.post.rawValue
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             let paramString = "{\"store\" : \"\(storeID)\", \"ratingCriteriaId\" : \"\(12)\"}"
                 request.httpBody = paramString.data(using: .utf8)
             Alamofire.request(request).responseJSON { (response) in
                 print(response)
                 if let statusCode = response.response?.statusCode {
                     if let res = response.result.value as? [NSDictionary] {
                         if statusCode >= 200 && statusCode < 300 {
                             if let comments: [Comment] = res.getObject() {
                                 completion(comments.map { CommentVM(comment: $0) }, nil)
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
    static func submitComment(comment :String ,storeId :Int , completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/store_rate_dtls/save")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var dic2 = "{\"compplaintypeid\" : \"\(2)\"}"
        var userdic2 = "{\"id\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\"}"
        let paramString = "{\"comments\" : \"\(comment)\", \"iscommentblocked\" : \"\("0")\", \"ratingValue\" : \("5"), \"store\" : \"\(storeId)\", \"ratingCriteriaId\" : \"\("12")\", \"userId\" : \(UserDefaultsAccess.sharedInstance.user?.id ?? 0)}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            if let statusCode = response.response?.statusCode {
                if statusCode == 201 {
                    completion(true, nil)
                } else {
                    completion(false, "\(statusCode) - Unable to add comment")
                }
            }
        }
    }
}
