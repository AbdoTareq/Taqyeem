//
//  ResturantSearchVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/25/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ResturantSearchVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var resturants: [ResturantVM]?
    var resturantsFiltered: [ResturantVM]?
    var resturantsFilteredByCategories: [ResturantVM]?
    var municID : Int = 0
    var districtID : Int = 0
    var streetID : Int = 0
    var lastSelectedIndex = 0
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var lblDistrict: UILabel!
    @IBOutlet weak var lblMunic: UILabel!
    var isFromRegister :Bool = false
    var currentSelectedCategoryID :Int = 0
    @IBOutlet weak var lblCurrentSelectedCategory: UILabel!
    var filterByCategory :Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSearch.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshResturants(_:)), name: .didMakeChange, object: nil)
        initNavigationBar()
    }
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @IBAction func showMunicFilter(_ sender: UIButton) {
        lastSelectedIndex =  sender.tag
        if sender.tag == 2 && self.municID == 0 {
            self.showAlert(message: "من فضلك قم باختيار البلدية")
            return
        }
        if sender.tag == 3 && (self.districtID == 0) {
            self.showAlert(message: "من فضلك قم باختيار حي")
            return
        }
        if sender.tag == 3 && (self.municID == 0) {
            self.showAlert(message: "من فضلك قم باختيار البلدية")
            return
        }
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "FiltersVC") as! FiltersVC
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.filterID =  sender.tag
        nextVC.searchVc =  self
        nextVC.municID =  self.municID
        nextVC.districtID =  self.districtID
        present(nextVC, animated: false, completion: nil)
    }
    
    func getData()  {
        self.startLoadingActivity()
        ResturantVM.getResturants { resturants , error in
            self.stopLoadingActivity()
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let resturants = resturants else {return}
            self.resturants = resturants
            self.tableView.delegate =  self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
            
        }
    }
    
    @IBAction func categoryfilterBtnClicked(_ sender: Any) {
        if self.municID != 0{
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "FoodCategoriesVC") as! FoodCategoriesVC
            nextVC.modalTransitionStyle = .crossDissolve
            nextVC.modalPresentationStyle = .overCurrentContext
            present(nextVC, animated: false, completion: nil)
        }
        else{
            self.showAlert(message: "برجاء اختيار البلدية")
        }
        
        
    }
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func refreshResturants(_ notification:Notification) {
        if self.lastSelectedIndex == 1 {
            self.getReturantsByMunic(municID: self.municID, enableLoader: false)
        }
        if self.lastSelectedIndex == 2 {
            self.getReturantsByDistrict(districtID: self.districtID, enableLoader: false)
        }
        if self.lastSelectedIndex == 3 {
            self.getReturantsByStreet(StreetID: self.streetID, enableLoader: false)
            
        }
    }
    
    func getReturantsByMunic(municID :Int, enableLoader: Bool = true)  {
        self.municID =  municID
        self.lblDistrict.text = "الحي"
        self.lblStreet.text = "الشارع"
        self.districtID = 0
        self.streetID = 0
        if enableLoader {
            self.startLoadingActivity()
        }
        ResturantVM.getResturantsByMunic(MunicID: municID) { resturants , error in
            if enableLoader {
                self.stopLoadingActivity()
            }
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let resturants = resturants else {return}
            self.resturants = resturants
            self.filterCurrentResturants()
            
            
            
        }
    }
    
    func getReturantsByDistrict(districtID: Int, enableLoader: Bool = true)  {
        
        self.lblStreet.text = "الشارع"
        self.streetID = 0
        self.districtID =  districtID
        if enableLoader {
            self.startLoadingActivity()
        }
        ResturantVM.getResturantsByDistrict(MunicID: self.municID, districtID: districtID) { resturants , error in
            if enableLoader {
                self.stopLoadingActivity()
            }
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let resturants = resturants else {return}
            self.resturants = resturants
            
            self.filterCurrentResturants()
        }
    }
    
    func getReturantsByStreet(StreetID: Int, enableLoader: Bool = true)  {
        self.streetID =  StreetID
        
        if enableLoader {
            self.startLoadingActivity()
        }
        ResturantVM.getResturantsBystreet(MunicID: self.municID, districtID: self.districtID , streetID :self.streetID) { resturants , error in
            if enableLoader {
                self.stopLoadingActivity()
            }
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let resturants = resturants else {return}
            self.resturants = resturants
            self.filterCurrentResturants()
        }
    }
    func filterCurrentResturantsByFoodCategory(name :String ,id :Int)  {
        if self.municID != 0{
            self.lblCurrentSelectedCategory.text = name
            self.currentSelectedCategoryID = id
            if resturantsFilteredByCategories != nil {
                resturantsFilteredByCategories?.removeAll()
            }
            resturantsFilteredByCategories = [ResturantVM]()
            //        if resturantsFiltered != nil {
            //            for item in resturantsFiltered! {
            //                for cate in item.categories {
            //                    if cate.category == id {
            //
            //                        self.resturantsFilteredByCategories?.append(item)
            //                    }
            //                }
            //            }
            //        }
            if resturants != nil {
                for item in resturants! {
                    for cate in item.categories {
                        if cate.category == id {
                            self.resturantsFilteredByCategories?.append(item)
                        }
                    }
                    
                }}
            else {}
            self.tableView.reloadData()
        }
        else {
            self.showAlert(message: "برجاء اختيار البلدية")
        }
    }
    
    
    func filterCurrentResturants() {
        if self.currentSelectedCategoryID != 0 {
            if resturantsFilteredByCategories != nil{
                resturantsFilteredByCategories?.removeAll()
            }
            resturantsFilteredByCategories = [ResturantVM]()
            if resturants != nil {
                for item in resturants! {
                    for cate in item.categories {
                        if cate.category == self.currentSelectedCategoryID  {
                            self.resturantsFilteredByCategories?.append(item)
                        }
                    }
                    
                }}
        }
        self.tableView.delegate =  self
        self.tableView.dataSource =  self
        self.tableView.reloadData()
        
    }
}
extension ResturantSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if resturantsFilteredByCategories != nil {
            return resturantsFilteredByCategories!.count
        }
            
        else if resturantsFiltered != nil {
            return resturantsFiltered!.count
        }
        else {
            return resturants?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantCell", for: indexPath) as! ResturantCell
        if resturantsFilteredByCategories != nil {
            cell.configureCell(resturant: self.resturantsFilteredByCategories![indexPath.row])
        }
        else if resturantsFiltered == nil {
            cell.configureCell(resturant: self.resturants![indexPath.row])
        } else {
            cell.configureCell(resturant: self.resturantsFiltered![indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isFromRegister{
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "ResturantDetailsVC") as! ResturantDetailsVC
            if resturantsFilteredByCategories != nil {
                nextVC.resturantVM =  self.resturantsFilteredByCategories![indexPath.row]
            }
            else if resturantsFiltered != nil {
                nextVC.resturantVM = self.resturantsFiltered![indexPath.row]
            }
            else {
                nextVC.resturantVM = self.resturants![indexPath.row]
            }
            
            UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            self.navigationController?.popViewController(animated: true, completion: {
                if let vc =  UIApplication.topViewController() as? LoginVC {
                    if self.resturantsFilteredByCategories != nil {
                        vc.goToRegistration(storeID: self.resturantsFilteredByCategories![indexPath.row].id)
                        
                    }
                        
                    else if self.resturantsFiltered == nil {
                        vc.goToRegistration(storeID: self.resturants![indexPath.row].id)
                    }
                    else {
                        vc.goToRegistration(storeID: self.resturantsFiltered![indexPath.row].id)
                    }
                    
                    
                }
            })
        }
    }
}
extension ResturantSearchVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            resturantsFiltered = nil
            tableView.reloadData()
            return
        }
        if textField.text?.count == 3 {
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textFieldString = textField.fullTextWith(range: range, replacementString: string) {
            if textFieldString == "" {
                resturantsFiltered = nil
                tableView.reloadData()
            }
            
            if textFieldString.count >= 3 {
                self.startLoadingActivity()
                resturantsFiltered = [ResturantVM]()
                resturantsFilteredByCategories = nil
                
                ResturantVM.getResturantsByname(searchText: textFieldString, foodCategory: self.currentSelectedCategoryID) { result, errorMessage in
                    self.stopLoadingActivity()
                    if  result != nil && result!.count > 0  {
                        self.resturantsFiltered =  result!
                        self.tableView.reloadData()
                    }
                    else {
                        self.showAlert(message: "لا يوجد نتائج للبحث")
                    }
                    
                }
            }
        }
        
        
        
        return true
    }
}
extension Notification.Name {
    static let didMakeChange = Notification.Name("didMakeChange")
    
}
extension UITextField {
    
    func fullTextWith(range: NSRange, replacementString: String) -> String? {
        
        if let fullSearchString = self.text, let swtRange = Range(range, in: fullSearchString) {
            
            return fullSearchString.replacingCharacters(in: swtRange, with: replacementString)
        }
        
        return nil
    }
}
