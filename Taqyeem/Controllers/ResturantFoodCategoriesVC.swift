//
//  ResturantFoodCategoriesVC.swift
//  Taqyeem
//
//  Created by Nourhan Hosny on 7/29/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import UIKit

class ResturantFoodCategoriesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var categories: [Categories]!
    var resturant : ResturantVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
       
        loadTable()
    }
    func loadTable() {
        if resturant != nil {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        }
    }
    func loadData(){
        self.startLoadingActivity()
        ResturantVM.getResturantByID(resturantID: UserDefaultsAccess.sharedInstance.user?.store ?? 0) { resturant, errorMessage in
            self.stopLoadingActivity()
            if resturant != nil {
            }
            else {
            }
        }
    }
    @IBAction func showFoodCategory(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "FoodCategoriesVC") as! FoodCategoriesVC
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.modalPresentationStyle = .overCurrentContext
        present(nextVC, animated: false, completion: nil)
    }
    
    func addNewCategory(categoryID :Int)  {
        self.startLoadingActivity()
        ResturantVM.addCategoryToResturant(resturantID: UserDefaultsAccess.sharedInstance.user?.store ?? 0, categoryID: categoryID) { success, errorMessage in
            self.stopLoadingActivity()
            if success {
                if let vc =  UIApplication.topViewController() as? OwnerController {
                    vc.loadData()
                }
            }
            else {
                self.showAlert(message: errorMessage ?? "")
            }
        }
    }
    func deleteCategory(categoryID : Int) {
        ResturantVM.deleteCategoryFromResturant(categoryId: categoryID) { success , errorMessage in
            if success {
                if let vc =  UIApplication.topViewController() as? OwnerController {
                    vc.loadData()
                }
            }
            else {
                self.showAlert(message: errorMessage ?? "")
            }
        }
    }
    
    
}
extension ResturantFoodCategoriesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resturant.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCategoryCell", for: indexPath) as! FoodCategoryCell
        cell.btnRemove.tag = self.resturant.categories[indexPath.row].id ?? 0
        cell.selectionStyle = .none
       cell.containerView.addShadow(color: .gray)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
