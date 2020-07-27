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
    var municID : Int = 0
    var districtID : Int = 0
    var streetID : Int = 0
    var lastSelectedIndex = 0
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var lblDistrict: UILabel!
    @IBOutlet weak var lblMunic: UILabel!
    var isFromRegister :Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSearch.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshResturants(_:)), name: .didMakeChange, object: nil)
        
        initNavigationBar()
        //        if self.resturants == nil {
        //            getData()
        //        }
    }
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @IBAction func showMunicFilter(_ sender: UIButton) {
        lastSelectedIndex =  sender.tag
        if sender.tag == 2 && self.municID == 0 {
            self.showAlert(message: "من فضلك قم باختيار بلديه")
            return
        }
        if sender.tag == 3 && (self.districtID == 0) {
            self.showAlert(message: "من فضلك قم باختيار حي")
            return
        }
        if sender.tag == 3 && (self.municID == 0) {
            self.showAlert(message: "من فضلك قم باختيار بلديه")
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
            self.tableView.delegate =  self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
            
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
            self.tableView.delegate =  self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
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
            self.tableView.delegate =  self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
        }
    }
    
}
extension ResturantSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resturantsFiltered != nil {
            return resturantsFiltered!.count
        }
        return resturants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantCell", for: indexPath) as! ResturantCell
        if resturantsFiltered == nil {
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
                   nextVC.resturantName = "مطعم المطار"
                   nextVC.resturantVM =  self.resturants![indexPath.row]
                   UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            self.navigationController?.popViewController(animated: true, completion: {
                if let vc =  UIApplication.topViewController() as? LoginVC {
                    vc.goToRegistration(storeID: self.resturants![indexPath.row].id)
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
        resturantsFiltered = [ResturantVM]()
        if let resturants = resturants, resturants.count > 0 {
            for resturant in resturants where resturant.name.contains(textField.text!) {
                resturantsFiltered!.append(resturant)
            }
            tableView.reloadData()
        }
    }
}
extension Notification.Name {
    static let didMakeChange = Notification.Name("didMakeChange")
    
}
