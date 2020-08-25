//
//  FoodCategoryCell.swift
//  Taqyeem
//
//  Created by Nourhan Hosny on 7/29/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import UIKit

class FoodCategoryCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var lblCategoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func removeCategory(_ sender: UIButton) {
        
        if let vc =  UIApplication.topViewController() as? OwnerController {
            vc.resturantFoodCategories.deleteCategory(categoryID: sender.tag)
        }
        
    }
    
}
