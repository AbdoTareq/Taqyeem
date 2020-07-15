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
    @IBOutlet weak var txtComment: UITextField!
    
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var showRateViewBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
    }
    @IBAction func rateBtnCliked(_ sender: UIButton) {
        if let vc = UIApplication.topViewController() as? RateVc {
            vc.rate(rateVal: Double(self.lblRate.text!) ?? 0.0, ratingCritriaId: sender.tag, comment: self.txtComment.text!)
        }
    }

    
    @IBAction func showRateView(_ sender: UIButton) {
        if let vc = UIApplication.topViewController() as? RateVc {
            vc.showActionasheetPicker(currentCellIndex: sender.tag, sender: sender)
        }
    }
}

}
