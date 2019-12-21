//
//  ContactKaseemVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/30/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ContactKaseemVC: UIViewController {
    
    @IBOutlet weak var vwMail: UIView!
    @IBOutlet weak var vwSocial: UIView!
    @IBOutlet weak var vwPhone: UIView!
    var contactUs: [ContactUsVM]?
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        vwMail.addShadow(color: UIColor.gray)
        vwSocial.addShadow(color: UIColor.gray)
        vwPhone.addShadow(color: UIColor.gray)
    }
    func getData() {
        ContactUsVM.get(category: 2) {contact, error in
            if contact != nil {
                self.contactUs = contact
            }
        }
    }
    func bindData() {
        guard let contacts = contactUs else { return }
        for contact in contacts {
            if contact.type == 3 {
                
            } else if contact.type == 1 {
                
            } else if contact.type == 2 {
                
            }
        }
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "التواصل مع امانة القصيم"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
