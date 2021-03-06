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
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        
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
                    }
                        
                    else if statusCode == 401 {
                        UserDefaultsAccess.sharedInstance.user = nil
                                         UIApplication.topViewController()?.stopLoadingActivity()
                                         UIApplication.topViewController()?.logOut()
                    }
                    else {
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
    
    
    static func submitRatingCriteria(ratingValue :Double ,ratingCriteriaId :Int ,storeId :Int,comment :String, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        guard let user = UserDefaultsAccess.sharedInstance.user, let id = user.id else {
            completion(false, "You must login")
            return
        }
        var request = URLRequest(url: URL(string: "http://healthctrl.qassim.gov.sa:8008/rating_app/store_rate_dtls/save")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"iscommentblocked\" : \"\("0")\", \"ratingValue\" : \(ratingValue), \"store\" : \"\(storeId)\", \"ratingCriteriaId\" : \"\(ratingCriteriaId)\", \"userId\" : \(UserDefaultsAccess.sharedInstance.user?.id ?? 0),\"comments\" : \"\(comment)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            if let statusCode = response.response?.statusCode {
                if statusCode == 201 {
                    completion(true, nil)
                }
                else if statusCode == 401 {
                    UserDefaultsAccess.sharedInstance.user = nil
                    UIApplication.topViewController()?.stopLoadingActivity()
                    UIApplication.topViewController()?.logOut()
                }
                else {
                    completion(false, "\(statusCode) - Unable to add rate")
                }
            }
        }
    }
    
    
}
