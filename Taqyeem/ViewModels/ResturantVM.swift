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
    var rating: Double {
        return resturant.rating ??  resturant.ratingValue ?? 0.0
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
        let url = NetworkManager.getUrl(service: .storesByMunicStreet)
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
        let paramString = "{\"userId\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let resturants: [Resturant] = res.getObject() {
                            completion(resturants.map { ResturantVM(resturant: $0) }, nil)
                        }
                    }
                    else {
                        
                    }
                } else {
                    completion(nil, "Unable to add resturant to favourites")
                }
            } else {
                completion(nil, "Unable to add resturant to favourites")
            }
        }
    }
    
    static func addReturantToFav(resturantID : Int , completion: @escaping (_ success :Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/favorit_stores/save")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"userId\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\", \"storeId\" : \"\(resturantID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if statusCode >= 200 && statusCode < 300 {
                    completion(true, nil)
                }
                if statusCode == 500  {
                    completion(false, "المطعم مضاف سابقا للمفضله")
                }
                else {
                    completion(false, "لم نتمكن من اضافه المطعم للمفضله")
                }
            }
            else {
                completion(false, "لم نتمكن من اضافه المطعم للمفضله")
            }
        }
    }
    
    static func removeReturantToFav(resturantID : Int , completion: @escaping (_ success :Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/favorit_stores/delete/")!)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let paramString = "{\"userId\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\", \"storeId\" : \"\(resturantID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if statusCode >= 200 && statusCode < 300 {
                    completion(true, nil)
                }
                    
                else {
                    completion(false, "لم نتمكن من حذف المطعم من المفضله")
                }
            }
            else {
                completion(false, "لم نتمكن من حذف المطعم من المفضله")
            }
        }
    }
    
}
