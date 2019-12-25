//
//  ResturantICollectionViewmage.swift
//  Taqyeem
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ResturantICollectionViewmage: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    func loadImage(image: String) {
        if let decodedData = Data(base64Encoded: image, options: .ignoreUnknownCharacters) {
            img.image = UIImage(data: decodedData)
        }
    }
}
