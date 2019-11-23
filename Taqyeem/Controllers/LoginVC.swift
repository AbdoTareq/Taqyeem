//
//  LoginVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSkip_Click(_ sender: UIButton) {
        UserDefaultsAccess.sharedInstance.skippedLogin = true
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "MainTBC") as! MainTBC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
