//
//  Streetvm.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
struct StreetVM {
    var street :Street
    static func getAllStreets(completion: @escaping (_ streets: [StreetVM]?, _ error: String?) -> Void) {
        var config = NetworkManager.Configuration(parameters: nil, url: .streets, method: .post)
        NetworkManager.makeRequest(configuration: config) {
            response in
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let streets: [Street] = res.getObject() {
                            completion(streets.map {StreetVM(street:  $0) }, nil)
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
