//
//  HomeVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var stackMain: HomeStack!
    
    @IBOutlet weak var loginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stackMain.initGestures()
        containerView.addShadow(color: UIColor.gray)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initNavigationBar()
        if UserDefaultsAccess.sharedInstance.user != nil {
            loginView.isHidden = true
        }
        else {
            loginView.isHidden = false
        }
        self.lblVersion.text = " الإصدار" + (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String ) 
        
    }
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
        self.tabBarController?.tabBar.isHidden =  false
    }
        
    @IBAction func loginBtnClicked(_ sender: Any) {
        UserDefaultsAccess.sharedInstance.skippedLogin  = false
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
