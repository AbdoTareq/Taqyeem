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
    
    @IBOutlet weak var stackMain: HomeStack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackMain.initGestures()
        containerView.addShadow(color: UIColor.gray)
    }

}
