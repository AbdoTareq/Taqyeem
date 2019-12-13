//
//  Resturant.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/12/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
struct Resturant: Codable {
    var storeId: Int?
    var storeArabicName: String?
    var municipalityId: String?
    var municipalityName: String?
    var districtId: Int?
    var districtName: String?
    var streetId: Int?
    var amanatActivity: String?
    var surveyActivity: String?
    var foodCategory: String?
    var streetName: String?
    //var ratingCriteriaId": null,
    var ratingCriteriaDescription: String?
    //var ratingValue": null,
    var activityCategory: String?
    var englishNameBanner: String?
    var latitude: Double?
    var longitude: Double?
    var mobile: String?
    var phone: String?
    var storeBuilding: String?
    var storeWebsite: String?
    //var utmX": null,
    //var utmY": null,
    var storeRatingDetails: String?
}
