//
//  GeneralNewsCell.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class GeneralNewsCell: UITableViewCell {
    @IBOutlet weak var vwContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vwContainer.addShadow(color: UIColor.darkGray)
    }

}
