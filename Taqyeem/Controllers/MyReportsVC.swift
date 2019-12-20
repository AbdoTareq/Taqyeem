//
//  MyReportsVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/27/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import  NotificationBannerSwift
class MyReportsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var reports: [ReportVM]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        initNavigationBar()
        loadData()
    }
    
    func loadData()  {
        self.startLoadingActivity()
        ReportVM.getMyReports { reports, errorMessage in
            self.stopLoadingActivity()
            if reports != nil {
                self.reports =  reports
                self.tableView.delegate =  self
                self.tableView.dataSource =  self
                self.tableView.reloadData()
            }
            else {
                let banner = StatusBarNotificationBanner(title: errorMessage!, style: .warning)
                banner.show()
            }
        }
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "بلاغاتي"
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
}
extension MyReportsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reports?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! ReportCell
        cell.configure(report: self.reports![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "ReportDetailsVC") as! ReportDetailsVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
}
