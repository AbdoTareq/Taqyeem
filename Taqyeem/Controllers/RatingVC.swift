//
//  RatingVC.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import Cosmos
import NotificationBannerSwift
class RatingVC: UIViewController {
    
    @IBOutlet weak var rsturantClean: CosmosView!
    @IBOutlet weak var severityQuality: CosmosView!
    @IBOutlet weak var foodQuality: CosmosView!
    @IBOutlet weak var barButonItemTitle: UIBarButtonItem!
    @IBOutlet weak var vwClearPlace: UIView!
    @IBOutlet weak var vwFastDelievery: UIView!
    @IBOutlet weak var vwFoodQuality: UIView!
    var resturantName : String = ""
    var resturant : Resturant =  Resturant()
    var rating = [RatingCriteriaVM]()
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
        loadData()
    }
    func loadData()  {
        RatingCriteriaVM.gerCriteries { critries, errorMessage in
            if critries != nil {
                self.rating =  critries!
            }
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func submitRatingCriteria(_ sender: Any) {
        if self.rating.count >= 1 {
            RatingCriteriaVM.submitRatingCriteria(ratingValue: self.foodQuality.rating, ratingCriteriaId: self.rating[0].id, storeId: self.resturant.storeId ?? 0) { success, errorMessage in
                if self.rating.count >= 2  {
                    RatingCriteriaVM.submitRatingCriteria(ratingValue: self.severityQuality.rating, ratingCriteriaId: self.rating[1].id, storeId: self.resturant.storeId ?? 0) { success, errorMessage in
                        if self.rating.count >= 3 {
                            RatingCriteriaVM.submitRatingCriteria(ratingValue: self.rsturantClean.rating, ratingCriteriaId: self.rating[2].id, storeId: self.resturant.storeId ?? 0) { success, errorMessage in
                                if success{
                                    let banner = StatusBarNotificationBanner(title: "تم اضافه تقيمك بنجاح", style: .success)
                                    banner.show()
                                    self.navigationController?.popViewController(animated: true)
                                }
                                
                            }
                        }
                    }
                }
                else {
                    
                }
                
            }
        }
    }
}
