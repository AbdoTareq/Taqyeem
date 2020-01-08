//
//  ForgetPasswordPhone.swift
//  Taqyeem
//
//  Created by mac on 1/8/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import SkyFloatingLabelTextField
class ForgetPasswordPhone: UIViewController {

    @IBOutlet weak var txtPhoneNumber: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPhoneNumber.isLTRLanguage =  false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
           navigationItem.setHidesBackButton(true, animated: false)
    }
    @IBAction func sendCodeBtnClicked(_ sender: Any) {
        self.startLoadingActivity()
        ForgetPasswordVM.getPasswordCode(mobile: self.txtPhoneNumber.text!) { user, errorMessage in
            self.stopLoadingActivity()
            if errorMessage == nil {
                let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordCode") as! ForgetPasswordCode
                       nextVC.code =  user!.token
                          nextVC.userID =  user?.id ?? 0
                         UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
            }
            else {
                let banner = StatusBarNotificationBanner(title: "حدث خطا", style: .warning)
                banner.show()
            }
        }
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
