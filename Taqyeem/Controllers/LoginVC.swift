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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
//        let story = UIStoryboard(name: "Main", bundle:nil)
//        let vc = story.instantiateViewController(withIdentifier: "MainTBC") as! MainTBC
//        let duration = TimeInterval(0.10)
//        let transition = UIWindow.Transition(style: .fade, duration: duration)
//        UIApplication.shared.setRootViewController(vc, transition: transition)
//        UserDefaultsAccess.sharedInstance.skippedLogin = UserDefaultsAccess.sharedInstance.user == nil
        
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
        self.startLoadingActivity()
        AuthenricationVM.login(mobile: txtPhone.text!, password: txtPassword.text!) {user, error in
            self.stopLoadingActivity()
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            if user != nil {
                UserDefaultsAccess.sharedInstance.user = user?.user
                UserDefaultsAccess.sharedInstance.skippedLogin = false
                UserDefaultsAccess.sharedInstance.token = user?.token ?? ""
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTBC") as! MainTBC
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func forgetPasswordBtn(_ sender: Any) {
    let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordPhone") as! ForgetPasswordPhone
          UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
      
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
