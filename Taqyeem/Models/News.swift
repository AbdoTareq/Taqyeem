//
//  News.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/2/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
struct News: Codable {
    var id: Int?
    var header: String?
    var text: String?
    var source: String?
    var url: String?
    var publicationDate: String?
    var image: String?
}
