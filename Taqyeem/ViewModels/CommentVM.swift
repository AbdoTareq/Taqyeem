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
        let paramString = "{\"store\" : \"\(storeID)\"}"
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
  
}
