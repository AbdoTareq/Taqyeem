//
//  ActivationCodeVC.swift
//  Taqyeem
//
//  Created by Nourhan Hosny on 7/28/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ActivationCodeVC: UIViewController {
    var user :AuthenricationVM?
    @IBOutlet weak var txtActivationCode: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func sendActivationCode(_ sender: Any) {
        if txtActivationCode.text != "" {
            self.startLoadingActivity()
            AuthenricationVM.validatePhone(id: user?.user.id ?? 0 , activationCode: txtActivationCode.text!) { success , errorMessage in
                self.stopLoadingActivity()
                if !(success ?? false) {
                    self.showAlert(message: errorMessage ?? "error")
                }
                else {
                    UserDefaultsAccess.sharedInstance.user = self.user?.user
                    self.navigationController?.popViewController(animated: false, completion: {
                        if let vc = UIApplication.topViewController() as? LoginVC {
                            vc.goToHomePage()
                        }
                    })
                                   
                }
            }
        }
       else {
           self.showAlert(message: "برجاء ادخال كود التفعيل")
        }
    }
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
