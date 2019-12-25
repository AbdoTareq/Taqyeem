//
//  ComplaintImage.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 12/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import UIKit
class ComplaintImage {
    var imgString: String?
    var img: UIImage?
    init(string: String, img: UIImage) {
        self.img = img
        imgString = string
    }
}
