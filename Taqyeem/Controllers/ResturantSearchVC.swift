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
    var municID : Int = 0
    var districtID : Int = 0
    var streetID : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        getData()
    }
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @IBAction func showMunicFilter(_ sender: UIButton) {
        if sender.tag == 2 && self.municID == 0 {
            self.showAlert(message: "من فضلك قم باختيار بريديه")
            return
        }
        if sender.tag == 3 && (self.districtID == 0) {
            self.showAlert(message: "من فضلك قم باختيار حي")
            return
        }
        if sender.tag == 3 && (self.municID == 0) {
            self.showAlert(message: "من فضلك قم باختيار بريديه")
            return
        }
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "FiltersVC") as! FiltersVC
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.filterID =  sender.tag
        nextVC.searchVc =  self
        present(nextVC, animated: false, completion: nil)
    }
    
    func getData()  {
        ResturantVM.getResturants { resturants , error in
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
    func getReturantsByMunic(municID :Int)  {
        self.municID =  municID
        ResturantVM.getResturantsByMunic(MunicID: municID) { resturants , error in
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let resturants = resturants else {return}
            self.resturants?.removeAll()
            self.resturants = resturants
            self.tableView.delegate =  self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
            
        }
    }
    func getReturantsByDistrict(districtID :Int)  {
        self.districtID =  districtID
        ResturantVM.getResturantsByDistrict(MunicID: self.municID, districtID: districtID) { resturants , error in
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let resturants = resturants else {return}
            self.resturants?.removeAll()
            self.resturants = resturants
            self.tableView.delegate =  self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
            
        }
    }
    func getReturantsByStreet(StreetID :Int)  {
        self.streetID =  StreetID
        ResturantVM.getResturantsBystreet(MunicID: self.municID, districtID: self.districtID , streetID :self.streetID) { resturants , error in
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let resturants = resturants else {return}
            self.resturants?.removeAll()
            self.resturants = resturants
            self.tableView.delegate =  self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
            
        }
    }
    
}
extension ResturantSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantCell", for: indexPath) as! ResturantCell
        cell.configureCell(resturant: self.resturants![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "ResturantDetailsVC") as! ResturantDetailsVC
        nextVC.resturantName = "مطعم المطار"
        nextVC.resturantVM =  self.resturants![indexPath.row]
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
}
