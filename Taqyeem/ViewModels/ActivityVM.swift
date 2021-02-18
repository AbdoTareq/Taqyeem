//
//  ActivityVM.swift
//  Taqyeem
//
//  Created by mac on 12/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct ActivityVM {
    var activity :Activity
    
    var id: Int {
        return activity.id ?? 0
    }
    var code: String {
        return activity.code ?? ""
    }
    var name: String {
        return activity.name ?? ""
    }
    var category: String {
        return activity.category ?? ""
    }
    var categoryCode: String {
        return activity.categoryCode ?? ""
    }
    static func getResturantActivities(storeID :Int , completion: @escaping (_ streets: [ActivityVM]?, _ error: String?) -> Void) {

        var request = URLRequest(url: URL(string: "http://healthctrl.qassim.gov.sa:8008/rating_app/food_categories/all")!)
               request.httpMethod = HTTPMethod.post.rawValue
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
               let paramString = "{\"storeId\" : \(storeID)}"
               request.httpBody = paramString.data(using: .utf8)
               Alamofire.request(request).responseJSON { (response) in
                   if let statusCode = response.response?.statusCode {
                       if let res = response.result.value as? [NSDictionary] {
                           if statusCode >= 200 && statusCode < 300 {
                               if let resturants: [Activity] = res.getObject() {
                                   completion(resturants.map { ActivityVM(activity:  $0) }, nil)
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
}
