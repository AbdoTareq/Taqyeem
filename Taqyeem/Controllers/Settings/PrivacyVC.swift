//
//  PrivacyVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/30/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class PrivacyVC: UIViewController {
    
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var vwContainer: UIView!
    var privacy: HelpVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        getData()
        vwContainer.addShadow(color: UIColor.gray)
    }
    func getData() {
        self.startLoadingActivity()
        HelpVM.get(type: 2) {help, error in
            self.stopLoadingActivity()
            if help != nil {
                self.privacy = help![0]
            } else {
                self.showAlert(message: error ?? "Failed to get data")
            }
            self.bindData()
        }
    }
    func bindData() {
        guard let privacy = privacy else { return }
        lblContent.text = privacy.text
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "سياسة الخصوصية"
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
}
