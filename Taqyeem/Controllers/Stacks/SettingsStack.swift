//
//  SettingsStack.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/30/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class SettingsStack: UIStackView {
    
    @IBOutlet weak var vwProfile: UIView!
    @IBOutlet weak var vwShare: UIView!
    @IBOutlet weak var vwHelp: UIView!
    @IBOutlet weak var vwReport: UIView!
    @IBOutlet weak var vwPrivacy: UIView!
    @IBOutlet weak var vwInfo: UIView!
    
    func initGestures() {
        let profileRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToProfile))
        vwProfile.addGestureRecognizer(profileRecognizer)
        
        let shareGesture = UITapGestureRecognizer(target: self, action: #selector(shareApp))
        vwShare.addGestureRecognizer(shareGesture)
        
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(goToHelp))
        vwHelp.addGestureRecognizer(helpGesture)
        
        let reportGesture = UITapGestureRecognizer(target: self, action: #selector(goToCreateReport))
        vwReport.addGestureRecognizer(reportGesture)
        
        let privacyGesture = UITapGestureRecognizer(target: self, action: #selector(goToPrivacy))
        vwPrivacy.addGestureRecognizer(privacyGesture)
        
        let infoGesture = UITapGestureRecognizer(target: self, action: #selector(goToInfo))
        vwInfo.addGestureRecognizer(infoGesture)
        
    }
    
    @objc func goToProfile(_: UITapGestureRecognizer) {
        if UserDefaultsAccess.sharedInstance.user == nil {
            UIApplication.topViewController()!.showAlert(message: "يجب عليك تسجيل الدخول للمتابعة")
            return
        }
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "UpdateProfile") as! UpdateProfile
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func shareApp(_: UITapGestureRecognizer) {
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "MyReportsVC") as! MyReportsVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func goToHelp(_: UITapGestureRecognizer) {
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func goToCreateReport(_: UITapGestureRecognizer) {
        if UserDefaultsAccess.sharedInstance.user == nil {
            UIApplication.topViewController()!.showAlert(message: "يجب عليك تسجيل الدخول للمتابعة")
            return
        }
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "CreateBugReportVC") as! CreateBugReportVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func goToPrivacy(_: UITapGestureRecognizer) {
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "PrivacyVC") as! PrivacyVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func goToInfo(_: UITapGestureRecognizer) {
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
}
