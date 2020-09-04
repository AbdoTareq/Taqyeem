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
        return resturant.storeArabicName ?? resturant.storeNameBanner ?? ""
    }
    var address: String {
        return "\(resturant.buildingNumber ?? 0) \(resturant.streetName ?? "") \(resturant.districtName ?? "")"
    }
    var rating: Double {
        return resturant.rating ??  resturant.rating ?? 0.0
    }
    
    var categories: [Categories] {
        return resturant.categories ??  [Categories]()
    }
    
    var images: [StoreImage] {
        return resturant.images ??  [StoreImage]()
    }
    
    
    static func getResturants(completion: @escaping (_ resturants: [ResturantVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .storesByMunic)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"municipalityId\" : \"\(4)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
    
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let resturants: [Resturant] = res.getObject() {
                            completion(resturants.map { ResturantVM(resturant: $0) }, nil)
                        }
                    }
                    else if statusCode == 401 {
                        UserDefaultsAccess.sharedInstance.user = nil
                        UIApplication.topViewController()?.stopLoadingActivity()
                        UIApplication.topViewController()?.logOut()
                    }else {
                        completion(nil, "عفوا، لا يوجد بيانات")
                    }
                } else {
                    completion(nil, "عفوا، لا يوجد بيانات")
                }
            } else {
                completion(nil, "عفوا، لا يوجد بيانات")
            }
        }
    }
    
    static func getResturantsByMunic(MunicID : Int , completion: @escaping (_ resturants: [ResturantVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .storesByMunic)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"municipalityId\" : \"\(MunicID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
          
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let resturants: [Resturant] = res.getObject() {
                            completion(resturants.map { ResturantVM(resturant: $0) }, nil)
                        }
                    }
                    else if statusCode == 401 {
                        UserDefaultsAccess.sharedInstance.user = nil
                        UIApplication.topViewController()?.stopLoadingActivity()
                        UIApplication.topViewController()?.logOut()
                    }else {
                        completion(nil, "عفوا، لا يوجد بيانات")
                    }
                } else {
                    completion(nil, "عفوا، لا يوجد بيانات")
                }
            } else {
                completion(nil, "عفوا، لا يوجد بيانات")
            }
        }
    }
    
    static func getResturantsByDistrict(MunicID : Int ,districtID :Int , completion: @escaping (_ resturants: [ResturantVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .storesByMunic)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"districtId\" : \"\(districtID)\", \"municipalityId\" : \"\(MunicID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
 
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let resturants: [Resturant] = res.getObject() {
                            completion(resturants.map { ResturantVM(resturant: $0) }, nil)
                        }
                    }
                    else if statusCode == 401 {
                        UserDefaultsAccess.sharedInstance.user = nil
                        UIApplication.topViewController()?.stopLoadingActivity()
                        UIApplication.topViewController()?.logOut()
                    }else {
                        completion(nil, "عفوا، لا يوجد بيانات")
                    }
                } else {
                    completion(nil, "عفوا، لا يوجد بيانات")
                }
            } else {
                completion(nil, "عفوا، لا يوجد بيانات")
            }
        }
    }
    
    static func getResturantsBystreet(MunicID : Int ,districtID :Int ,streetID:Int , completion: @escaping (_ resturants: [ResturantVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .storesByMunicStreet)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"districtId\" : \"\(districtID)\", \"municipalityId\" : \"\(MunicID)\", \"streetId\" : \"\(streetID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
       
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let resturants: [Resturant] = res.getObject() {
                            completion(resturants.map { ResturantVM(resturant: $0) }, nil)
                        }
                    }else if statusCode == 401 {
                        UserDefaultsAccess.sharedInstance.user = nil
                        UIApplication.topViewController()?.stopLoadingActivity()
                        UIApplication.topViewController()?.logOut()
                    } else {
                        completion(nil, "عفوا، لا يوجد بيانات")
                    }
                } else {
                    completion(nil, "عفوا، لا يوجد بيانات")
                }
            } else {
                completion(nil, "عفوا، لا يوجد بيانات")
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
         request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"userId\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
         
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let resturants: [Resturant] = res.getObject() {
                            completion(resturants.map { ResturantVM(resturant: $0) }, nil)
                        }
                    }else if statusCode == 401 {
                        UserDefaultsAccess.sharedInstance.user = nil
                        UIApplication.topViewController()?.stopLoadingActivity()
                        UIApplication.topViewController()?.logOut()
                    }
                    else {
                        
                    }
                } else {
                    completion(nil, "Unable to get favourites")
                }
            } else {
                completion(nil, "Unable to get favourites")
            }
        }
    }
    
    static func addReturantToFav(resturantID : Int , completion: @escaping (_ success :Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/favorit_stores/save")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"userId\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\", \"storeId\" : \"\(resturantID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
           
            if let statusCode = response.response?.statusCode {
                if statusCode >= 200 && statusCode < 300 {
                    completion(true, nil)
                }else if statusCode == 401 {
                    UserDefaultsAccess.sharedInstance.user = nil
                    UIApplication.topViewController()?.stopLoadingActivity()
                    UIApplication.topViewController()?.logOut()
                } else if statusCode == 500  {
                    completion(false, "المطعم مضاف سابقا للمفضله")
                } else {
                    completion(false, "لم نتمكن من اضافه المطعم للمفضله")
                }
            } else {
                completion(false, "لم نتمكن من اضافه المطعم للمفضله")
            }
        }
    }
    
    static func removeReturantToFav(resturantID : Int , completion: @escaping (_ success :Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/favorit_stores/delete/")!)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"userId\" : \"\(UserDefaultsAccess.sharedInstance.user?.id ?? 0)\", \"storeId\" : \"\(resturantID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
     
            if let statusCode = response.response?.statusCode {
                if statusCode >= 200 && statusCode < 300 {
                    completion(true, nil)
                }else if statusCode == 401 {
                    UserDefaultsAccess.sharedInstance.user = nil
                    UIApplication.topViewController()?.stopLoadingActivity()
                    UIApplication.topViewController()?.logOut()
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
    
    static func getResturantByID(resturantID :Int ,completion: @escaping (_ resturants: ResturantVM?, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/stores/\(resturantID)")!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        Alamofire.request(request).responseJSON { (response) in
           
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? NSDictionary {
                    if statusCode >= 200 && statusCode < 300 {
                        if let resturants: Resturant = res.getObject() {
                            completion( ResturantVM(resturant: resturants), nil)
                        }
                    }else if statusCode == 401 {
                        UserDefaultsAccess.sharedInstance.user = nil
                        UIApplication.topViewController()?.stopLoadingActivity()
                        UIApplication.topViewController()?.logOut()
                    } else {
                        completion(nil, "عفوا، لا يوجد بيانات")
                    }
                } else {
                    completion(nil, "عفوا، لا يوجد بيانات")
                }
            } else {
                completion(nil, "عفوا، لا يوجد بيانات")
            }
        }
    }
    
    
    static func addCategoryToResturant(resturantID : Int ,categoryID:Int, completion: @escaping (_ success :Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/stores_category/save")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"store\" : \"\(resturantID)\", \"category\" : \"\(categoryID)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
     
            if let statusCode = response.response?.statusCode {
                if statusCode >= 200 && statusCode < 300 {
                    if let res = response.result.value as? NSDictionary {
                        if let resturants: Categories = res.getObject() {
                            completion(true, nil)
                        }
                    }
                }else if statusCode == 401 {
                    UserDefaultsAccess.sharedInstance.user = nil
                    UIApplication.topViewController()?.stopLoadingActivity()
                    UIApplication.topViewController()?.logOut()
                }
                    
                else {
                    if let res = response.result.value as? NSDictionary {
                        completion(false, res["errorMessage"] as? String ?? "" )
                    }
                    
                }
            }
            else {
                completion(false, "لم نتمكن من اضافه  القسم للمطعم")
            }
        }
    }
    
    
    static func deleteCategoryFromResturant(categoryId : Int , completion: @escaping (_ success :Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/stores_category_del/\(categoryId)")!)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        Alamofire.request(request).responseJSON { (response) in
          
            if let statusCode = response.response?.statusCode {
                if statusCode >= 200 && statusCode < 300 {
                    completion(true, nil)
                }else if statusCode == 401 {
                    UserDefaultsAccess.sharedInstance.user = nil
                    UIApplication.topViewController()?.stopLoadingActivity()
                    UIApplication.topViewController()?.logOut()
                }
                    
                else {
                    if let res = response.result.value as? NSDictionary {
                        completion(false, res["errorMessage"] as? String ?? "" )
                    }}
            }
            else {
                completion(false, "لم نتمكن من الحذف ")
            }
        }
    }
    static func addimageToResturant(resturantID : Int ,image:String, completion: @escaping (_ success :Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/store/save_images")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "[{\"store\" : \"\(resturantID)\", \"storeImage\" : \"\(image)\"}]"
        
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
      
            if let statusCode = response.response?.statusCode {
                if statusCode >= 200 && statusCode < 300 {
                    completion(true, nil)
                }else if statusCode == 401 {
                    UserDefaultsAccess.sharedInstance.user = nil
                    UIApplication.topViewController()?.stopLoadingActivity()
                    UIApplication.topViewController()?.logOut()
                }
                else {
                    if let res = response.result.value as? NSDictionary {
                        completion(false, res["errorMessage"] as? String ?? "" )
                    }}
            }
            else {
                completion(false, "لم نتمكن من إضافه الصوره ")
            }
        }
    }
    
    
    static func deleteImageFromResturant(imageId : Int , completion: @escaping (_ success :Bool, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/store/delete_images/\(imageId)")!)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        Alamofire.request(request).responseJSON { (response) in

            if let statusCode = response.response?.statusCode {
                if statusCode >= 200 && statusCode < 300 {
                    completion(true, nil)
                }else if statusCode == 401 {
                    UserDefaultsAccess.sharedInstance.user = nil
                    UIApplication.topViewController()?.stopLoadingActivity()
                    UIApplication.topViewController()?.logOut()
                }
                    
                else {
                    if let res = response.result.value as? NSDictionary {
                        completion(false, res["errorMessage"] as? String ?? "" )
                    }}
            }
            else {
                completion(false, "لم نتمكن من الحذف ")
            }
        }
    }
    static func getResturantsByname(searchText :  String,foodCategory:Int, completion: @escaping (_ resturants: [ResturantVM]?, _ error: String?) -> Void) {
          let url = NetworkManager.getUrl(service: .searchByName)
          var request = URLRequest(url: URL(string: url)!)
          request.httpMethod = HTTPMethod.post.rawValue
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
          let paramString = "{\"foodCategory\" : \"\(foodCategory)\", \"storeId\" : \"\(0)\", \"storeNameLicense\" : \"\(searchText)\"}"
          request.httpBody = paramString.data(using: .utf8)
          Alamofire.request(request).responseJSON { (response) in
              
              if let statusCode = response.response?.statusCode {
                  if let res = response.result.value as? [NSDictionary] {
                      if statusCode >= 200 && statusCode < 300 {
                          if let resturants: [Resturant] = res.getObject() {
                              completion(resturants.map { ResturantVM(resturant: $0) }, nil)
                          }
                      }else if statusCode == 401 {
                          UserDefaultsAccess.sharedInstance.user = nil
                          UIApplication.topViewController()?.stopLoadingActivity()
                          UIApplication.topViewController()?.logOut()
                      } else {
                          completion(nil, "عفوا، لا يوجد بيانات")
                      }
                  } else {
                      completion(nil, "عفوا، لا يوجد بيانات")
                  }
              } else {
                  completion(nil, "عفوا، لا يوجد بيانات")
              }
          }
      }
}
