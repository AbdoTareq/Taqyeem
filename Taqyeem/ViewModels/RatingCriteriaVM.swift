//
//  RatingCriteriaVM.swift
//  Taqyeem
//
//  Created by mac on 12/21/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct RatingCriteriaVM {
var rateCriteria :RatingCriteria
    var id: Int {
           return rateCriteria.id ?? 0
       }
       var description: String {
           return rateCriteria.description ?? ""
       }
    
    static func gerCriteries(completion: @escaping (_ criteries: [RatingCriteriaVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .ratingCriteria)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = ""
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let resturants: [RatingCriteria] = res.getObject() {
                            completion(resturants.map { RatingCriteriaVM(rateCriteria: $0) }, nil)
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
    
    
    static func submitRatingCriteria(ratingValue :Double ,ratingCriteriaId :Int ,storeId :Int, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/store_rate_dtls/save")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"comments\" : \"\("")\", \"iscommentblocked\" : \"\("0")\", \"ratingValue\" : \(ratingValue), \"store\" : \"\(storeId)\", \"ratingCriteriaId\" : \"\(ratingCriteriaId)\", \"userId\" : \(UserDefaultsAccess.sharedInstance.user?.id ?? 0)}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            if let statusCode = response.response?.statusCode {
                if statusCode == 201 {
                    completion(true, nil)
                } else {
                    completion(false, "\(statusCode) - Unable to add rate")
                }
            }
        }
    }
    
    
}
