//
//  ContactUsVM.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/21/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct ContactUsVM {
    var contactUs: ContactUs
    var id: Int {
        return contactUs.id ?? 0
    }
    var value: String {
        return contactUs.contact ?? ""
    }
    var type: Int {
        return contactUs.contactType ?? 0
    }
    static func get(category: Int, completion: @escaping (_ contactUs: [ContactUsVM]?, _ error: String?) -> Void) {
        let url = NetworkManager.getUrl(service: .contact)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        let paramString = "{\"category\" : \"\(category)\"}"
        request.httpBody = paramString.data(using: .utf8)
        Alamofire.request(request).responseJSON { (response) in
            print(response)
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let contacts: [ContactUs] = res.getObject() {
                            completion(contacts.map { ContactUsVM(contactUs: $0) }, nil)
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
