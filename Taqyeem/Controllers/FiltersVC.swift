//
//  MunicVC.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class FiltersVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var filterID : Int = 0
    var munics: [MunicVM]?
    var districts: [DistrictVM]?
    var streets: [StreetVM]?
    var searchVc : ResturantSearchVC!
    @IBOutlet weak var lblPopupTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    var municID =  0
    var districtID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
        self.tableView.delaysContentTouches =  false
    }
    func prepareData() {
        switch self.filterID {
        case 1:
            getMunics()
            lblPopupTitle.text = "اختر البلديه"
        case 2:
            getDistricts()
            lblPopupTitle.text = "اختر الاسكان"
        case 3:
            getStreets()
            lblPopupTitle.text = "اختر الاحد"
        default:
            break
        }
    }
    
    func getMunics() {
        self.startLoadingActivity()
        MunicVM.getAllMunics{munics, error in
            self.stopLoadingActivity()
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let munics = munics else {return}
            self.munics = munics
            self.tableView.delegate =  self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
            
        }
    }
    func getDistricts() {
        self.startLoadingActivity()
        DistrictVM.getAllDistricts(municID: self.municID){districts, error in
             self.stopLoadingActivity()
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let districts = districts else {return}
            self.districts = districts
            self.tableView.delegate = self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
        }
    }
    func getStreets() {
        self.startLoadingActivity()
        StreetVM.getAllStreets(municID: self.municID, districtID: self.districtID){streets, error in
             self.stopLoadingActivity()
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let streets = streets else {return}
            self.streets = streets
            self.tableView.delegate = self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view !=  containerView {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
extension FiltersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.filterID {
        case 1:
            return  munics?.count ?? 0
        case 2:
            return  districts?.count ?? 0
        case 3:
            return  streets?.count ?? 0
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
        switch filterID {
        case 1:
            cell.lblTitle.text = self.munics![indexPath.row].munic.name
        case 2:
            cell.lblTitle.text = self.districts![indexPath.row].district.name
        case 3:
            cell.lblTitle.text = self.streets![indexPath.row].street.name
        default:
            break
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch self.filterID {
        case 1:
            self.searchVc.municID = self.munics![indexPath.row].munic.id ?? 0
            self.dismiss(animated: true) {
                self.searchVc.lblMunic.text = self.munics![indexPath.row].munic.name
                self.searchVc.getReturantsByMunic(municID: self.munics![indexPath.row].munic.id ?? 0)
            }
        case 2:
            self.searchVc.districtID = self.districts![indexPath.row].district.id ?? 0
            self.dismiss(animated: true) {
                self.searchVc.lblDistrict.text = self.districts![indexPath.row].district.name
                self.searchVc.getReturantsByDistrict(districtID: self.districts![indexPath.row].district.id ?? 0)
            }
        case 3:
              self.searchVc.streetID = self.streets![indexPath.row].street.id ?? 0
            self.dismiss(animated: true) {
                self.searchVc.lblStreet.text = self.streets![indexPath.row].street.name
                self.searchVc.getReturantsByStreet(StreetID: self.streets![indexPath.row].street.id ?? 0)
            }
        default:
            break
        }
    }
}
