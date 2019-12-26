//
//  RateVc.swift
//  Taqyeem
//
//  Created by mac on 12/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import NotificationBannerSwift
class RateVc: UIViewController {
    var rating = [RatingCriteriaVM]()
    @IBOutlet weak var barButonItemTitle: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var resturant : Resturant =  Resturant()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.tabBarController?.hidesBottomBarWhenPushed =  true
        self.tabBarController?.tabBar.isHidden = true
        barButonItemTitle.title = "تقييم مطعم  " + (resturant.storeArabicName ?? resturant.storeNameBanner ?? "" ) 
        self.navigationItem.setHidesBackButton(true, animated:true)
        barButonItemTitle.tintColor =  UIColor.white
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func loadData()  {
        RatingCriteriaVM.gerCriteries { critries, errorMessage in
            if critries != nil {
                self.rating = critries!
                self.tableView.delegate =  self
                self.tableView.dataSource =  self
                self.tableView.reloadData()
            }
        }
    }
    func rate(rateVal :Double , ratingCritriaId :Int ,comment:String)  {
        self.startLoadingActivity()
        RatingCriteriaVM.submitRatingCriteria(ratingValue: rateVal, ratingCriteriaId: ratingCritriaId, storeId: self.resturant.storeId ?? 0, comment: comment) { success, errorMessage in
            self.stopLoadingActivity()
            if success {
                let banner = StatusBarNotificationBanner(title: "تم اضافه تقيمك بنجاح", style: .success)
                banner.show()
                 NotificationCenter.default.post(name: .didMakeChange, object: nil , userInfo: nil)
                
            } else {
                let banner = StatusBarNotificationBanner(title: "لم نتمكن من اضافه تقييمك", style: .warning)
                banner.show()
            }
        }
    }
    
}
extension RateVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rating.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RateCell", for: indexPath) as! RateCell
        cell.critriaName.text =  self.rating[indexPath.row].description
        cell.rateBtn.tag = self.rating[indexPath.row].id
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
