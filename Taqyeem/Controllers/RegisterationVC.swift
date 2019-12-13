//
//  RegisterationVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class RegisterationVC: UIViewController {
    
    @IBOutlet weak var txtFirstName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtLastName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtFamilyName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPhone: SkyFloatingLabelTextField!
    @IBOutlet weak var txtMail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var txtConfirmPassword: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }
    func register() {
        if txtFirstName.text == "" {
            showAlert(message: "برجاء ادخال الاسم الاول")
            return
        }
        if txtLastName.text == "" {
            showAlert(message: "برجاء ادخال الاسم الخير")
            return
        }
        if txtFamilyName.text == "" {
            showAlert(message: "برجاء ادخال اسم العائلة")
            return
        }
        if txtPhone.text == "" {
            showAlert(message: "برجاء ادخال رقم الهاتف")
            return
        }
        if txtMail.text == "" {
            showAlert(message: "برجاء ادخال البريد الالكتروني")
            return
        }
        if txtPassword.text == "" {
            showAlert(message: "برجاء ادخال كلمة المرور")
            return
        }
        if txtConfirmPassword.text == "" {
            showAlert(message: "برجاء ادخال تأكيد كلمة المرور")
            return
        }
        if txtConfirmPassword.text != txtPassword.text {
            showAlert(message: "كلمة المرور غير متطابقة")
            return
        }
        let user = User(id: nil, firstName: txtFirstName.text!, lastName: txtLastName.text!, nickName: txtFamilyName.text, email: txtMail.text!, image: nil, token: nil, mobile: txtPhone.text!, password: txtPassword.text)
        AuthenricationVM.register(user: user) {success, error in
            if !success {
                if error != nil {
                    self.showAlert(message: error!)
                } else {
                    self.showAlert(message: "Unable to register")
                }
                return
            }
            self.login(mobile: self.txtPhone.text!, password: self.txtPassword.text!)
        }
    }
    func login(mobile: String, password: String) {
        AuthenricationVM.login(mobile: mobile, password: password) {user, error in
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            if user != nil {
                UserDefaultsAccess.sharedInstance.user = user?.user
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
    
    @IBAction func btnLogin_Click(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
