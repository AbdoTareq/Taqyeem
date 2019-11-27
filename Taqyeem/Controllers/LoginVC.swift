//
//  LoginVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class LoginVC: UIViewController {

    @IBOutlet weak var txtPhone: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
    }

    func initNavigationBar() {
           navigationController?.setNavigationBarHidden(true, animated: true)
           //navigationItem.title = "مطاعمي المفضلة"
    }

    @IBAction func btnSkip_Click(_ sender: UIButton) {
        UserDefaultsAccess.sharedInstance.skippedLogin = true
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "MainTBC") as! MainTBC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
