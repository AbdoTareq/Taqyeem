//
//  CreateReportDetailsCell.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/27/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class CreateReportDetailsCell: UITableViewCell {

    @IBOutlet weak var txtDetails: UITextView!
    @IBOutlet weak var lblLinesCount: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
        txtDetails.delegate = self
    }
}
extension CreateReportDetailsCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == txtDetails, text != "" {
            return textView.text!.count < 220
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView == txtDetails {
            lblLinesCount.text = "\(textView.text!.count)/220"
        }
    }
}
