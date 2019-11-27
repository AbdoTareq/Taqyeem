//
//  ContactVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {

    @IBOutlet weak var stackContact: ContactStack!
    override func viewDidLoad() {
        super.viewDidLoad()
        stackContact.initGestures()
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
