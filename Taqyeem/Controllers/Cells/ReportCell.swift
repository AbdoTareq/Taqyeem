//
//  ReportCell.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/27/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ReportCell: UITableViewCell {

    @IBOutlet weak var lblReportDate: UILabel!
    @IBOutlet weak var lblReportTitle: UILabel!
    @IBOutlet weak var vwContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vwContainer.addShadow(color: UIColor.darkGray)
    }
     
    func configure(report :ReportVM) {
        self.lblReportDate.text =  report.complainDate
        self.lblReportTitle.text =  report.complaininformername
    }
   

}
