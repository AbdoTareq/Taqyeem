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
        self.lblResturantName.text = resturant.resturant.storeNameBanner ??  resturant.resturant.storeArabicName
        let resturantNumb : String = String(resturant.resturant.buildingNumber ?? 0 )
        let resturantRat : Int = resturant.resturant.rating ?? resturant.resturant.ratingValue ?? 0
        self.lblResturantAddress.text = resturantNumb + " " + resturant.resturant.streetName! + " " + resturant.resturant.districtName!
        self.vwRating.rating =  Double(resturantRat)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
