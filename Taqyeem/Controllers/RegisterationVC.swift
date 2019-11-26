//
//  RegisterationVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class RegisterationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
    }
    
    func initNavigationBar() {
           navigationController?.setNavigationBarHidden(true, animated: true)
           //navigationItem.title = "مطاعمي المفضلة"
    }

}
