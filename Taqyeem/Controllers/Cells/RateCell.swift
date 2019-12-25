//
//  RateCell.swift
//  Taqyeem
//
//  Created by mac on 12/24/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import Cosmos
class RateCell: UITableViewCell {
    @IBOutlet weak var critriaName: UILabel!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var txtComment: UITextField!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
    }
    @IBAction func rateBtnCliked(_ sender: UIButton) {
        if let vc = UIApplication.topViewController() as? RateVc {
            vc.rate(rateVal: self.rateView.rating, ratingCritriaId: sender.tag, comment: self.txtComment.text!)
        }
    }
}
