//
//  RatingVC.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class RatingVC: UIViewController {

    @IBOutlet weak var barButonItemTitle: UIBarButtonItem!
    @IBOutlet weak var vwClearPlace: UIView!
    @IBOutlet weak var vwFastDelievery: UIView!
    @IBOutlet weak var vwFoodQuality: UIView!
    var resturantName : String = ""
    var resturant : Resturant =  Resturant()
    override func viewDidLoad() {
        super.viewDidLoad()
        vwClearPlace.addShadow(color: UIColor.gray)
        vwFastDelievery.addShadow(color: UIColor.gray)
        vwFoodQuality.addShadow(color: UIColor.gray)
        barButonItemTitle.title = "تقييم مطعم  " + resturant.storeArabicName!
         self.navigationItem.setHidesBackButton(true, animated:true)
        self.tabBarController?.hidesBottomBarWhenPushed =  true
         self.tabBarController?.tabBar.isHidden = true
        barButonItemTitle.tintColor =  UIColor.white
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden = false
    }
}
