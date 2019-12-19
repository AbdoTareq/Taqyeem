//
//  ServiceBase.swift
//  Salon-Admin
//
//  Created by Mostafa on 9/20/17.
//  Copyright © 2017 Mostafa. All rights reserved.
//

import Foundation
enum ServiceBase: String {
    case munic = "munic/all"
    case district = "district/all"
    case districtByMunic = "district_by_munic"
    case streets = "streets/all"
    case streetsByDistrict = "streets_by_district_id"
    case streetsByMunic = "streets_by_munic"
    case streetsByMunicDist = "streets_by_munic_dist_ids"
    case ratingAndComments = "store_rate_crt_dtls/all"
     case saveComment = "store_rate_dtls/save"
    case activities = "activities/all"
    case ratingCriteria = "/rate_cr/all"
    case stores = "stores_global"
    case storesByMunic = "stores_by_munic"
    case storesByMunicDist = "stores_by_munic_dist"
    case storesByMunicStreet = "stores_by_street"
    
    case storeRating = "store_avg_ratings"
    case storeRatingDetails = "store_avg_spec_ratings"
    
    case news = "news"
    case publications = "publication"
    
    case register = "user/save"
    case login = "user/authenticate"

    case reports = "comp/save"
    //case createReport = "comp"
    case favStores = "favorit_stores/user_fav"
}
