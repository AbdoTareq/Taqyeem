//
//  ContactStack.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/27/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ContactStack: UIStackView {
    @IBOutlet weak var vwCreateReport: UIView!
    @IBOutlet weak var vwMyReports: UIView!
    @IBOutlet weak var vwContact: UIView!
    @IBOutlet weak var vwContactManagement: UIView!
    
    func initGestures() {
        let createReportRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToCreateReport))
        vwCreateReport.addGestureRecognizer(createReportRecognizer)
        
        let myReportsGesture = UITapGestureRecognizer(target: self, action: #selector(goToMyReports))
        vwMyReports.addGestureRecognizer(myReportsGesture)
        
    }
    @objc func goToCreateReport(_: UITapGestureRecognizer) {
          let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "CreateReportVC") as! CreateReportVC
          UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
      }
      @objc func goToMyReports(_: UITapGestureRecognizer) {
          let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "MyReportsVC") as! MyReportsVC
          UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
      }
}
