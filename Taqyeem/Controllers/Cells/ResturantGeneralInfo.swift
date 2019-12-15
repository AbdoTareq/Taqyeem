//
//  ResturantGeneralInfo.swift
//  Taqyeem
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import Cosmos
class ResturantGeneralInfo: UITableViewCell {

    @IBOutlet weak var lblresturantDisc: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var containerView: UIView!
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
