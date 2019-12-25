//
//  Report.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/4/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
struct Report: Codable {
    var id: Int?
    var complaininformername: String?
    var complaintext: String?
    var storename: String?
    var mobile: Int?
    var mobileuser : User?
    var complaindate: String?
    var complainimages: [String]?
}
