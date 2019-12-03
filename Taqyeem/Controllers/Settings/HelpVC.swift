//
//  HelpVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/30/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        vwContainer.addShadow(color: UIColor.gray)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "المساعدة"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
