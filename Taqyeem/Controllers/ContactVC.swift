//  ContactVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Created by Mostafa sayed on 11/30/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackContact: ContactStack!

    override func viewDidLoad() {
        super.viewDidLoad()
        stackContact.initGestures()
        containerView.addShadow(color: UIColor.gray)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initNavigationBar()
    }
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
