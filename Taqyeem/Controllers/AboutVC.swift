//
//  AboutVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblContent: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        vwContainer.addShadow(color: UIColor.darkGray)
        initNavigationBar()
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "نبذة عن الادارة العامة لصحة البيئة"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
