//
//  ResturantCell.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/25/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import Cosmos
class ResturantCell: UITableViewCell {

    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var lblResturantAddress: UILabel!
    @IBOutlet weak var lblResturantName: UILabel!
    @IBOutlet weak var vwContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vwContainer.addShadow(color: UIColor.darkGray)
    }
    func configureCell(resturant :ResturantVM) {
        self.lblResturantName.text = resturant.name
        self.lblResturantAddress.text = resturant.address
        self.vwRating.rating =  Double(resturant.rating)
    }
}
