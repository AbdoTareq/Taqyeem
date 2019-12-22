//
//  ReportType.swift
//  Taqyeem
//
//  Created by mac on 12/22/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ReportType: UITableViewCell {

    @IBOutlet weak var reportType: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
  
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
