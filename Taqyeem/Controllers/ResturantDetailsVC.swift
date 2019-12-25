//
//  ResturantDetailsVC.swift
//  Taqyeem
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import MapKit
import CoreLocation
class ResturantDetailsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var resturantName = ""
    var resturantVM : ResturantVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        initNavigationBar()
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = resturantVM.resturant.storeNameBanner ??  resturantVM.resturant.storeArabicName ?? ""
        navigationItem.setHidesBackButton(true, animated: false)
    }

    @objc func btnRatingClicked(_ sender: UIButton) {
        guard let user = UserDefaultsAccess.sharedInstance.user, let id = user.id else {
            let alertController = UIAlertController(title: "تسجيل الدخول", message: "يتوجب عليك تسجيل الدخول", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "موافق", style: UIAlertAction.Style.default) {
                UIAlertAction in
                UserDefaultsAccess.sharedInstance.skippedLogin  = false
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                nextVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            }
            let cancelAction = UIAlertAction(title: "الغاء", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
            return
        }
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "RateVc") as! RateVc
        nextVC.resturant =  self.resturantVM.resturant
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    @objc func btnCommentsClicked(_ sender: UIButton) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "CommentsVC") as! CommentsVC
        nextVC.resturant = self.resturantVM.resturant
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    @objc func btnAddToFaveClicked(_ sender: UIButton) {
        guard let user = UserDefaultsAccess.sharedInstance.user, let id = user.id else {
            let alertController = UIAlertController(title: "تسجيل الدخول", message: "يتوجب عليك تسجيل الدخول", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "موافق", style: UIAlertAction.Style.default) {
                UIAlertAction in
                UserDefaultsAccess.sharedInstance.skippedLogin  = false
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                nextVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            }
            let cancelAction = UIAlertAction(title: "الغاء", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
            return
        }
        
        if self.resturantVM != nil {
            self.startLoadingActivity()
            ResturantVM.addReturantToFav(resturantID: self.resturantVM.resturant.storeId ?? 0) { success, errorMessage in
                self.stopLoadingActivity()
                if success {
                    let banner = StatusBarNotificationBanner(title: "تم اضافه المطعم للمفضله", style: .success)
                    banner.show()
                }
                else {
                    if errorMessage!.contains("مضاف"){
                        self.removeReturantFromFav()
                    }
                    else {
                        
                        let banner = StatusBarNotificationBanner(title: errorMessage!, style: .warning)
                        banner.show()
                    }
                }
            }
            
        }
    }
    func removeReturantFromFav() {
        let alertController = UIAlertController(title: "المفضله", message: "المطعم مضاف سابقا للمفضله", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "موافق", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
        }
        let cancelAction = UIAlertAction(title: "حذف من المفضله", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            self.startLoadingActivity()
            ResturantVM.removeReturantToFav(resturantID: self.resturantVM.resturant.storeId ?? 0) { (success, errorMessage) in
                self.stopLoadingActivity()
                if success {
                    let banner = StatusBarNotificationBanner(title: "تم حذف المطعم من المفضله", style: .success)
                    banner.show()
                }
                else {
                    let banner = StatusBarNotificationBanner(title: errorMessage!, style: .warning)
                    banner.show()
                }
                
            }
            
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func showDirectionClicked(_ sender: UIButton) {
        let location = CLLocation(latitude: self.resturantVM.resturant.latitude ?? 0.0, longitude: self.resturantVM.resturant.longitude ?? 0.0)
        self.openMapForLocation(location: location, zoom: 2, locationName: self.resturantVM.resturant.storeArabicName ?? "", title: self.resturantVM.resturant.storeArabicName ?? "", googleTitle: "Google Map", appleTitle: "Apple Map", cancelTitle: "cancel")
    }
    @objc func showResturantActivities(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ActivitiesVC") as! ActivitiesVC
        nextVC.storeID =  self.resturantVM.id
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}
extension ResturantDetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantGeneralInfo", for: indexPath) as! ResturantGeneralInfo
            cell.lblresturantDisc.text =  (self.resturantVM.resturant.amanatActivity ?? "" + " - " + (self.resturantVM.resturant.surveyActivity ?? ""))
            
            cell.vwRating.rating =  Double(self.resturantVM.resturant.rating ?? self.resturantVM.resturant.ratingValue ?? 0 )
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantLocation", for: indexPath) as! ResturantLocation
            let resturant =  self.resturantVM.resturant
            let resturantNumb : String = String(resturant.buildingNumber ?? 0 )
            cell.lblResturantAddress.text = resturantNumb + " " + resturant.streetName! + " " + resturant.districtName!
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantImages", for: indexPath) as! ResturantImages
            cell.loadData()
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCommentRateCell", for: indexPath) as! ShowCommentRateCell
            cell.ratingBtn.addTarget(self, action: #selector(btnRatingClicked(_:)), for: .touchUpInside)
            cell.btnComments.addTarget(self, action: #selector(btnCommentsClicked(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantActivitiesDirections", for: indexPath) as! ResturantActivitiesDirections
            cell.btnAddToFav.addTarget(self, action: #selector(btnAddToFaveClicked(_:)), for: .touchUpInside)
            cell.btnDirections.addTarget(self, action: #selector(showDirectionClicked(_:)), for: .touchUpInside)
            cell.btnResturantActivities.addTarget(self, action: #selector(showResturantActivities(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
