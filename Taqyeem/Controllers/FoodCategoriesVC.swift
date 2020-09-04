//
//  FoodCategoriesVC.swift
//  Taqyeem
//
//  Created by Nourhan Hosny on 7/29/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import UIKit

class FoodCategoriesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var activities: [ActivityVM]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
               tableView.rowHeight = UITableView.automaticDimension
        getactivities()
            self.tableView.delaysContentTouches =  false
    }
    func getactivities() {
          self.startLoadingActivity()
        ActivityVM.getResturantActivities(storeID: UserDefaultsAccess.sharedInstance.user?.store ?? 0) { activities, errorMessage in
              self.stopLoadingActivity()
              if errorMessage != nil {
                  self.showAlert(message: errorMessage!)
                  return
              }
              guard let activities = activities else {return}
              self.activities = activities
              self.tableView.delegate = self
              self.tableView.dataSource =  self
              self.tableView.reloadData()
          }
      }

}
extension FoodCategoriesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
        cell.lblTitle.text =  self.activities![indexPath.row].name
        //cell.containerView.addShadow(color: UIColor.gray)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.dismiss(animated: false) {
            if let vc = UIApplication.topViewController() as? OwnerController {
                vc.resturantFoodCategories.addNewCategory(categoryID: self.activities![indexPath.row].id)
            }
            if let vc = UIApplication.topViewController() as? ResturantSearchVC {
                vc.filterCurrentResturantsByFoodCategory(name: self.activities![indexPath.row].name, id: self.activities![indexPath.row].id)
            }
            
        }
        
    }
}
