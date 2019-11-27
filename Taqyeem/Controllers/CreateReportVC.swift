//
//  CreateReportVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/27/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class CreateReportVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "تقديم بلاغ/شكوي"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
extension CreateReportVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
            cell = tableView.dequeueReusableCell(withIdentifier: "CreateReportImagesCell", for: indexPath) as! CreateReportImagesCell
            return cell
        }
        if indexPath.row == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CreateReportSendCell", for: indexPath) as! CreateReportSendCell
            return cell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
