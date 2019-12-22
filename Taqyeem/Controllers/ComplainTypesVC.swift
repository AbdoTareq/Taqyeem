//
//  ComplainTypesVC.swift
//  Taqyeem
//
//  Created by mac on 12/22/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ComplainTypesVC: UIViewController {
@IBOutlet weak var tableView: UITableView!
     var complains: [ComplainTypeVM]?
    override func viewDidLoad() {
        super.viewDidLoad()
          getData()
}
    
    func getData() {
           self.startLoadingActivity()
        ComplainTypeVM.getAllComplainTypes { complains, errorMessage in
            
                self.stopLoadingActivity()
               if errorMessage != nil {
                   self.showAlert(message: errorMessage!)
                   return
               }
               guard let complains = complains else {return}
               self.complains = complains
               self.tableView.delegate = self
               self.tableView.dataSource =  self
               self.tableView.reloadData()
           }
       }
    
}
extension ComplainTypesVC: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.complains?.count ?? 0
    }
    


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
    cell.lblTitle.text = self.complains![indexPath.row].complainType
    return cell
}
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: false)
    self.dismiss(animated: true) {
        if let vc = UIApplication.topViewController() as? CreateReportVC {
            vc.complainType =  self.complains![indexPath.row].complainType
              vc.complainId =  self.complains![indexPath.row].compplaintypeId
            vc.reloadReportType()
        }
    }
    }

}
