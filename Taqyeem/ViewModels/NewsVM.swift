//
//  NewsVM.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/2/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
struct NewsVM {
    var news: News
    
    var id: Int {
        return news.id ?? 0
    }
    
    var title: String {
        return news.header ?? ""
    }
    var body: String {
        return news.text ?? ""
    }
    var image: String {
        return news.image ?? ""
    }
    var date: String {
        return news.publicationDate ?? ""
    }
    static func getNews(completion: @escaping (_ users: [NewsVM]?, _ error: String?) -> Void) {
        var config = NetworkManager.Configuration(parameters: nil, url: .news, method: .get)
        config.urlParameters = "all"
        NetworkManager.makeRequest(configuration: config) {
            response in
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? [NSDictionary] {
                    if statusCode >= 200 && statusCode < 300 {
                        if let news: [News] = res.getObject() {
                            completion(news.map { NewsVM(news: $0) }, nil)
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
    static func getDetails(id: Int, completion: @escaping (_ users: NewsVM?, _ error: String?) -> Void) {
        var config = NetworkManager.Configuration(parameters: nil, url: .news, method: .get)
        config.urlParameters = "\(id)"
        NetworkManager.makeRequest(configuration: config) {
            response in
            if let statusCode = response.response?.statusCode {
                if let res = response.result.value as? NSDictionary {
                    if statusCode >= 200 && statusCode < 300 {
                        if let news: News = res.getObject() {
                            completion(NewsVM(news: news), nil)
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
