//
//  User.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/3/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
struct User: Codable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var nickName: String?
    var email: String?
    var image: String?
    var token: String?
    var mobile: String?
    var password: String?
    var jwttoken :String?
    var isAdmin :Int?
    var accountActivated  :Int?
    var owner :Int?
    var store : Int?
}
