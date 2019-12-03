//
//  BulletainVM.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/3/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
struct BulletainVM {
    var Bulletain: News
    
    var id: Int {
        return Bulletain.id ?? 0
    }
    
    var title: String {
        return Bulletain.header ?? ""
    }
    var body: String {
        return Bulletain.text ?? ""
    }
    var image: String {
        return Bulletain.image ?? ""
    }
    var date: String {
        return Bulletain.publicationDate ?? ""
    }
    static func getPublications(completion: @escaping (_ users: [BulletainVM]?, _ error: String?) -> Void) {
        var config = NetworkManager.Configuration(parameters: nil, url: .publications, method: .get)
        config.urlParameters = "all"
        NetworkManager.makeRequest(configuration: config) {
            response in
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let news: [News] = res.getObject() {
                            completion(news.map { BulletainVM(Bulletain: $0) }, nil)
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
