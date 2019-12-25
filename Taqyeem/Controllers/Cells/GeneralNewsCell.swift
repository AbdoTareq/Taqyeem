//
//  GeneralNewsCell.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import Kingfisher
class GeneralNewsCell: UITableViewCell {
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        vwContainer.addShadow(color: UIColor.darkGray)
    }
    func bindData(news: NewsVM) {
        lblDetails.text = news.body
        lblTitle.text = news.title
        lblDetails.text = news.body
        lblDate.text = news.date
//        if let decodedData = Data(base64Encoded: news.image, options: .ignoreUnknownCharacters) {
//            img.image = UIImage(data: decodedData)
//        }
    }
    func bindDataBulletain(bulletain: BulletainVM) {
        lblDetails.text = bulletain.body
        lblTitle.text = bulletain.title
        lblDetails.text = bulletain.body
        lblDate.text = bulletain.date
//        if let decodedData = Data(base64Encoded: bulletain.image, options: .ignoreUnknownCharacters) {
//            img.image = UIImage(data: decodedData)
//        }
    }
}
