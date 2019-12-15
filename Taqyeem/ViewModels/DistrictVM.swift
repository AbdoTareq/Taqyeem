//
//  DistrictVM.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
struct DistrictVM {
    var district :District
    static func getAllDistricts(completion: @escaping (_ users: [DistrictVM]?, _ error: String?) -> Void) {
        var config = NetworkManager.Configuration(parameters: nil, url: .district, method: .post)
        NetworkManager.makeRequest(configuration: config) {
            response in
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let districts: [District] = res.getObject() {
                    
                            completion(districts.map {DistrictVM(district: $0) }, nil)
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
