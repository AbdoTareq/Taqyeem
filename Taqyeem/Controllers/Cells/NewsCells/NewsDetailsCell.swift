//
//  NewsDetailsCell.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class NewsDetailsCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblBody: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
    }
    func bindData(body: String) {
        lblBody.text = body
    }

}
