//
//  NewsImageCell.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class NewsImageCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
    }

    func bindData(base64: String) {
        if let decodedData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) {
            img.image = UIImage(data: decodedData)
        }
    }

}
