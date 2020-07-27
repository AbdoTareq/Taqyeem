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
                self.navigationController?.popViewController(animated: false)
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
//        if let vc = self.tabBarController as? MainTBC {
//            //vc.setUpLoginPageInTabBar()
//            vc.selectedIndex = 2
//        }
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnRegister_Click(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "RegisterationVC") as! RegisterationVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnLogin_Click(_ sender: UIButton) {
        login()
    }
    
    
    @IBAction func registerAsOwnerBtnClicked(_ sender: Any) {
       
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "ResturantSearchVC") as! ResturantSearchVC
        nextVC.isFromRegister =  true
      self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    func goToRegistration(storeID :Int)  {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "RegisterationVC") as! RegisterationVC
        nextVC.storeId  = storeID
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
extension SkyFloatingLabelTextField {
    open override func awakeFromNib() {
        self.isLTRLanguage = false
    }
}
