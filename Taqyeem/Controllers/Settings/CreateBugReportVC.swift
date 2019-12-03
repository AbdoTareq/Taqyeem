//
//  CreateBugReportVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/30/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class CreateBugReportVC: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblLinesCount: UILabel!
    @IBOutlet weak var txtDetails: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        viewContainer.addShadow(color: UIColor.gray)
        txtDetails.delegate = self
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "ابلغ عن خطأ"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
extension CreateBugReportVC: UITextViewDelegate {
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
