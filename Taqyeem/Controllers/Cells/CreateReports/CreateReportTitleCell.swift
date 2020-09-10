//
//  CreateReportTitleCell.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/27/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class CreateReportTitleCell: UITableViewCell{

    @IBOutlet weak var txtTitle: UITextView!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        txtTitle.delegate = self
        containerView.addShadow(color: UIColor.gray)
        txtTitle.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
extension CreateReportTitleCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if let vc = UIApplication.topViewController() as? CreateReportVC {
           
                                                                                                                                                       vc.reportTitle = textView.text!
        }
    }
    
}
