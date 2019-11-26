//
//  ResturantCell.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/25/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ResturantCell: UITableViewCell {

    @IBOutlet weak var vwContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vwContainer.addShadow(color: UIColor.darkGray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
