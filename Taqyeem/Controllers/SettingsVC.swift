//
//  SettingsVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var stackSettings: SettingsStack!
    override func viewDidLoad() {
        super.viewDidLoad()
        stackSettings.initGestures()
        containerView.addShadow(color: UIColor.gray)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initNavigationBar()
    }
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
        self.tabBarController?.tabBar.isHidden =  false
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
