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
    func login() {
        if txtPhone.text == "" {
            showAlert(message: "برجاء ادخال رقم الهاتف")
            return
        }
        if txtPassword.text == "" {
            showAlert(message: "برجاء ادخال كلمة المرور")
            return
        }
        AuthenricationVM.login(mobile: txtPhone.text!, password: txtPassword.text!) {user, error in
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            if user != nil {
                UserDefaultsAccess.sharedInstance.user = user
                UserDefaultsAccess.sharedInstance.skippedLogin = false
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTBC") as! MainTBC
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
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

    @IBAction func btnRegister_Click(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "RegisterationVC") as! RegisterationVC
               self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func btnLogin_Click(_ sender: UIButton) {
        login()
    }
}
extension SkyFloatingLabelTextField {
    open override func awakeFromNib() {
        self.isLTRLanguage = false
    }
}
