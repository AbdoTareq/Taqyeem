//
//  ReportResturantName.swift
//  Taqyeem
//
//  Created by mac on 12/22/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import GrowingTextView
class ReportResturantName: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var resturantName: GrowingTextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
