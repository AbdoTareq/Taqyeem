//
//  Comment.swift
//  Taqyeem
//
//  Created by mac on 12/15/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
struct Comment: Codable {
    var id:Int?
    var comments:String?
    var iscommentblocked :Int?
    var ratingValue : Double?
    var ratingdatetime :String?
    var store :Int?
    var ratingCriteriaId :Int?
    var ratingCriteriaDesc :String?
    var userId :Int?
    var userFullName:String?
    var mobile :String?
    var image :String?
}
