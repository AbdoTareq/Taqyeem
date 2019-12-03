//
//  PrivacyVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/30/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class PrivacyVC: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
      override func viewDidLoad() {
          super.viewDidLoad()
          initNavigationBar()
          vwContainer.addShadow(color: UIColor.gray)
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
