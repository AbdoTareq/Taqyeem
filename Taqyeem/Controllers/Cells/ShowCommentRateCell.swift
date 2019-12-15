//
//  ShowCommentRateCell.swift
//  Taqyeem
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ShowCommentRateCell: UITableViewCell {

    @IBOutlet weak var btnComments: UIButton!
    @IBOutlet weak var ratingBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
    }

   

}
