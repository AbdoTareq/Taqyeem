//
//  HomeVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    
    @IBOutlet weak var stackMain: HomeStack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackMain.roundCorners()
        stackMain.layer.cornerRadius = 20
        stackMain.masksToBounds = true
        stackMain.layer.masksToBounds = true
        stackMain.clipsToBounds = true
    }

}
