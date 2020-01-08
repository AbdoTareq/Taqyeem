//
//  ForgetPasswordCode.swift
//  Taqyeem
//
//  Created by mac on 1/8/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import NotificationBannerSwift
class ForgetPasswordCode: UIViewController {
    var code :String = ""
    var userID : Int = 0
    @IBOutlet weak var lblConfirmationCode: SkyFloatingLabelTextField!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    var phoneNumber :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
  navigationItem.setHidesBackButton(true, animated: false)
        
        lblPhoneNumber.text =  self.phoneNumber
    }
    
    
    @IBAction func uploadConfirmationCodeClicked(_ sender: Any) {
        if self.lblConfirmationCode.text ==  code {
            let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordNew") as! ForgetPasswordNew
            nextVC.userID =  self.userID
          UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            let banner = StatusBarNotificationBanner(title: "كود خطا", style: .warning)
                banner.show()
        }
    }
    
    
    @IBAction func BckBtnClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    

}
