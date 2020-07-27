//
//  ForgetPasswordNew.swift
//  Taqyeem
//
//  Created by mac on 1/8/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import NotificationBannerSwift
class ForgetPasswordNew: UIViewController {
    var userID :Int = 0
    @IBOutlet weak var lblConfirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var LblNewPassword: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePasswordClicked(_ sender: Any) {
        if self.lblConfirmPassword.text != self.LblNewPassword.text {
            let banner = StatusBarNotificationBanner(title: "كلمه المرور غير متطابقه", style: .warning)
            banner.show()
        }
        else {
            self.startLoadingActivity()
            ForgetPasswordVM.changePassword(newPassword: self.LblNewPassword.text!, userID: self.userID) { success, errorMessage in
                self.stopLoadingActivity()
                if success! {
                    let banner = StatusBarNotificationBanner(title: "تم تغيير كلمه المرور بنجاح", style: .success)
                    banner.show()
                    
                    let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
                }
                else {
                    let banner = StatusBarNotificationBanner(title: "حدث خطا", style: .warning)
                    banner.show()
                }
            }
        }
    }
    
}

