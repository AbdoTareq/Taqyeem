//
//  UpdateProfile.swift
//  Taqyeem
//
//  Created by mac on 12/21/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import  NotificationBannerSwift
class UpdateProfile: UIViewController {
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFamilyName: UITextField!
    @IBOutlet weak var txtSecondName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        self.tabBarController?.tabBar.isHidden =  true
        bindDataToUi()
    }
    
    func bindDataToUi() {
        self.txtMobile.text = UserDefaultsAccess.sharedInstance.user?.mobile ?? ""
        self.txtEmail.text = UserDefaultsAccess.sharedInstance.user?.email ?? ""
        self.txtFirstName.text = UserDefaultsAccess.sharedInstance.user?.firstName ?? ""
        self.txtSecondName.text = UserDefaultsAccess.sharedInstance.user?.lastName ?? ""
        self.txtFamilyName.text = UserDefaultsAccess.sharedInstance.user?.nickName ?? ""
    }
    @IBAction func btnSveClicked(_ sender: Any) {
        if txtFirstName.text == "" {
            showAlert(message: "برجاء ادخال الاسم الاول")
            return
        }
        if txtSecondName.text == "" {
            showAlert(message: "برجاء ادخال الاسم الخير")
            return
        }
        if txtFamilyName.text == "" {
            showAlert(message: "برجاء ادخال اسم العائلة")
            return
        }
        if txtMobile.text == "" {
            showAlert(message: "برجاء ادخال رقم الهاتف")
            return
        }
        if txtEmail.text == "" {
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
        self.startLoadingActivity()
        let user = User(id: nil, firstName: txtFirstName.text!, lastName: txtSecondName.text!, nickName: txtFamilyName.text, email: txtEmail.text!, image: nil, token: nil, mobile: txtMobile.text!, password: txtPassword.text)
        self.startLoadingActivity()
        AuthenricationVM.update(user: user) {success, error in
            self.stopLoadingActivity()
            if !success {
                if error != nil {
                    self.showAlert(message: error!)
                } else {
                    self.stopLoadingActivity()
                    self.showAlert(message: "Unable to update profile")
                }
                return
            }
            self.login(mobile: self.txtMobile.text!, password: self.txtPassword.text!)
        }
        
    }
    func login(mobile: String, password: String) {
        AuthenricationVM.login(mobile: mobile, password: password) {user, error in
            self.stopLoadingActivity()
            if error != nil {
                self.showAlert(message: "Unable to update profile")
                return
            }
            if user != nil {
                UserDefaultsAccess.sharedInstance.user = user?.user
                let banner = StatusBarNotificationBanner(title: "تم  تعديل حسابك بنجاح", style: .success)
                banner.show()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden =  false
    }
}
