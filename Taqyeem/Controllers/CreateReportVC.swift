//
//  CreateReportVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/27/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import NotificationBannerSwift
class CreateReportVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var reportTitle :String = ""
    var reportDescription :String = ""
    var storeName :String = ""
    var complainType = ""
    var complainId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "تقديم بلاغ/شكوي"
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @objc func btnSubmitReportClicked(_ sender: UIButton) {
           prepareReportsData()
        if self.complainId == 0 || storeName == "" || reportTitle == "" || reportDescription == "" {
            let banner = StatusBarNotificationBanner(title: "من فضلك ادخل جمبع البيانات", style: .warning)
            banner.show()
        }
        else {
        self.startLoadingActivity()
     
        ReportVM.submitReport(complainInformation: self.reportTitle, complainText: self.reportDescription , mobile: UserDefaultsAccess.sharedInstance.user?.mobile ?? "", storename: self.storeName, complainId: self.complainId) { success , errorMessage in
            self.stopLoadingActivity()
            if success {
                let banner = StatusBarNotificationBanner(title: "تم اضافه بلاغك بنجاح", style: .success)
                banner.show()
                self.navigationController?.popViewController(animated: true)
            }
            else {
                let banner = StatusBarNotificationBanner(title: errorMessage!, style: .warning)
                banner.show()
            }
        }
        }
    }
    func prepareReportsData()  {
        for cellItem in  self.tableView.visibleCells {
            if  let cell =  cellItem as? CreateReportTitleCell {
                self.reportTitle = cell.txtTitle!.text!
            }
            if let  cell = cellItem as? CreateReportDetailsCell {
                self.reportDescription  = cell.txtDetails.text!
            }
            if let  cell = cellItem as? ReportResturantName {
                self.storeName  = cell.resturantName.text!
            }
        }
    }
    func reloadReportType() {
        let indexPath = IndexPath(item: 3, section: 0)
        tableView.reloadRows(at: [indexPath], with: .top)
    }
}
extension CreateReportVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CreateReportTitleCell", for: indexPath) as! CreateReportTitleCell
            return cell
        }
        if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CreateReportDetailsCell", for: indexPath) as! CreateReportDetailsCell
            return cell
        }
        if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "ReportResturantName", for: indexPath) as! ReportResturantName
            return cell
        }
        if indexPath.row == 3 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ReportType", for: indexPath) as! ReportType
            if self.complainType != ""{
                cell.reportType.text = self.complainType
            }
          return cell
        }
        if indexPath.row == 4 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CreateReportImagesCell", for: indexPath) as! CreateReportImagesCell
            return cell
        }
        if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateReportSendCell", for: indexPath) as! CreateReportSendCell
            cell.btnSubmitReport.addTarget(self, action: #selector(btnSubmitReportClicked(_:)), for: .touchUpInside)
            return cell
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ComplainTypesVC") as! ComplainTypesVC
                 nextVC.modalTransitionStyle = .crossDissolve
                 nextVC.modalPresentationStyle = .overCurrentContext
                 present(nextVC, animated: false, completion: nil)
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
