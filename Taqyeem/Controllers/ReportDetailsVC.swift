//
//  ReportDetailsVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/27/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ReportDetailsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblReportDate: UILabel!
    @IBOutlet weak var lblReportDescription: UILabel!
    
    @IBOutlet weak var lblReportTitle: UILabel!
    var report :ReportVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        tableView.delegate = self
        tableView.dataSource =  self
        tableView.reloadData()
        
    }
   
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "عرض البلاغ"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
extension ReportDetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
          let  cell = tableView.dequeueReusableCell(withIdentifier: "ReportTitleCell", for: indexPath) as! ReportTitleCell
            cell.lblTitle.text = report.complaininformername
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReportDetailsCell", for: indexPath) as! ReportDetailsCell
            cell.lblReportDescription.text =  self.report.complaintext
            return cell
        }
        if indexPath.row == 2 {
           let  cell = tableView.dequeueReusableCell(withIdentifier: "ReportImagesCell", for: indexPath) as! ReportImagesCell
            
            return cell
        }
        if indexPath.row == 3 {
           let  cell = tableView.dequeueReusableCell(withIdentifier: "ReportDateCell", for: indexPath) as! ReportDateCell
            cell.lblReportDate.text =  self.report.complainDate
            return cell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
