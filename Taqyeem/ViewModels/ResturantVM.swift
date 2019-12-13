//
//  ResturantVM.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/12/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct ResturantVM {
    var resturant: Resturant
    func getResturants(completion: @escaping (_ users: [Resturant]?, _ error: String?) -> Void) {
        var config = NetworkManager.Configuration(parameters: nil, url: .stores, method: .post)
        config.urlParameters = "all"
        NetworkManager.makeRequest(configuration: config) {
            response in
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        //if let news: [Resturant] = res.getObject() {
                            //completion(news.map { Resturant(resturant: $0) }, nil)
                        //}
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
    static func getFavourites(completion: @escaping (_ users: [ResturantVM]?, _ error: String?) -> Void) {
        guard let user = UserDefaultsAccess.sharedInstance.user, let id = user.id else {
            completion(nil, "You must login")
            return
        }
        let url = NetworkManager.getUrl(service: .favStores)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"userId\" : \"\(41)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? NSDictionary {
                    if statusCode >= 200 && statusCode < 300 {
                        if let resturants: [Resturant] = res.getObject() {
                            completion(resturants.map { ResturantVM(resturant: $0) }, nil)
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
