//
//  ResturantDetailsVC.swift
//  Taqyeem
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

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
        navigationItem.title =   resturantVM.resturant.storeNameBanner ??  resturantVM.resturant.storeArabicName ?? ""
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
   
    @objc func btnRatingClicked(_ sender: UIButton) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
        nextVC.resturant =  self.resturantVM.resturant
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    @objc func btnCommentsClicked(_ sender: UIButton) {
          let nextVC = storyboard?.instantiateViewController(withIdentifier: "CommentsVC") as! CommentsVC
          nextVC.resturant =  self.resturantVM.resturant
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
            let rate  =  Int(self.resturantVM.resturant.rating ?? 0 )
            cell.vwRating.rating =  Double(rate)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantLocation", for: indexPath) as! ResturantLocation
            let resturant =  self.resturantVM.resturant
            let resturantNumb : String = String(resturant.buildingNumber ?? 0 )
            cell.lblResturantAddress.text = resturantNumb + " " + resturant.streetName! + " " + resturant.districtName!
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantImages", for: indexPath) as! ResturantImages
            cell.loadData()
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCommentRateCell", for: indexPath) as! ShowCommentRateCell
            cell.ratingBtn.addTarget(self, action: #selector(btnRatingClicked(_:)), for: .touchUpInside)
         cell.btnComments.addTarget(self, action: #selector(btnCommentsClicked(_:)), for: .touchUpInside)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantActivitiesDirections", for: indexPath) as! ResturantActivitiesDirections
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
