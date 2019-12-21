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
    var id: Int {
        return resturant.storeId ?? 0
    }
    var name: String {
        return resturant.storeNameBanner ?? resturant.storeArabicName ?? ""
    }
    var address: String {
        return "\(resturant.buildingNumber ?? 0) \(resturant.streetName ?? "") \(resturant.districtName ?? "")"
    }
    var rating: Int {
        return resturant.rating ?? 0
    }
   
    static func getResturants(completion: @escaping (_ resturants: [ResturantVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .storesByMunic)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"municipalityId\" : \"\(4)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
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
    static func getResturantsByMunic(MunicID : Int , completion: @escaping (_ resturants: [ResturantVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .storesByMunic)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"municipalityId\" : \"\(MunicID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
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
    static func getResturantsByDistrict(MunicID : Int ,districtID :Int , completion: @escaping (_ resturants: [ResturantVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .storesByMunic)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"districtId\" : \"\(districtID)\", \"municipalityId\" : \"\(MunicID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
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
    
    static func getResturantsBystreet(MunicID : Int ,districtID :Int ,streetID:Int , completion: @escaping (_ resturants: [ResturantVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .storesByMunic)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"districtId\" : \"\(districtID)\", \"municipalityId\" : \"\(MunicID)\", \"streetId\" : \"\(streetID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
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
                if let res = response.result.value as? [NSDictionary] {
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
