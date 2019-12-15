//
//  MunicVM.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
struct MunicVM {
    var munic :Munic
    
    static func getAllMunics(completion: @escaping (_ munics: [MunicVM]?, _ error: String?) -> Void) {
        var config = NetworkManager.Configuration(parameters: nil, url: .munic, method: .post)
        NetworkManager.makeRequest(configuration: config) {
            response in
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let munics: [Munic] = res.getObject() {
                            completion(munics.map {MunicVM(munic: $0) }, nil)
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
