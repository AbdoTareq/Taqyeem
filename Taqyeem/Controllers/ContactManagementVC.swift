//
//  ContactManagementVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/30/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ContactManagementVC: UIViewController {
    
    @IBOutlet weak var vwMail: UIView!
    @IBOutlet weak var vwSocial: UIView!
    @IBOutlet weak var vwPhone: UIView!
    
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblTwitter: UILabel!
    @IBOutlet weak var lblFacebook: UILabel!
    
    var contactUs: [ContactUsVM]?
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        getData()
        vwMail.addShadow(color: UIColor.gray)
        vwSocial.addShadow(color: UIColor.gray)
        vwPhone.addShadow(color: UIColor.gray)
    }
    func getData() {
        self.startLoadingActivity()
        ContactUsVM.get(category: 1) {contact, error in
            self.stopLoadingActivity()
            if contact != nil {
                self.contactUs = contact
            } else {
                self.showAlert(message: error ?? "Failed to get data")
            }
            self.bindData()
        }
    }
    func bindData() {
        guard let contacts = contactUs else { return }
        var i = 0
        for contact in contacts {
                i += 1
                if contact.type == 3 {
                    lblFacebook.isHidden = false
                    lblFacebook.tag = i
                    let fbClicked = UITapGestureRecognizer(target: self, action: #selector(goTOFB))
                    lblFacebook.addGestureRecognizer(fbClicked)
                } else if contact.type == 1 {
                    lblPhone.text = contact.value
                    lblPhone.tag = i
                    let phoneClicked = UITapGestureRecognizer(target: self, action: #selector(call))
                    lblPhone.addGestureRecognizer(phoneClicked)
                } else if contact.type == 2 {
                    lblEmail.text = contact.value
                    lblEmail.tag = i
                    let mailClicked = UITapGestureRecognizer(target: self, action: #selector(mail))
                    lblEmail.addGestureRecognizer(mailClicked)
                }
            }
        }
        @objc func goTOFB(_ gesture: UITapGestureRecognizer) {
            guard let contacts = contactUs else { return }
            if let index = gesture.view?.tag {
                if let url = URL(string: contacts[index].value) {
                    UIApplication.shared.open(url)
                }
            }
        }
        @objc func call(_ gesture: UITapGestureRecognizer) {
            guard let contacts = contactUs else { return }
            if let index = gesture.view?.tag {
                
                let appUrl = "tel://\(contacts[index].value)"
                if let url = URL(string: appUrl), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        }
        
        @objc func mail(_ gesture: UITapGestureRecognizer) {
            guard let contacts = contactUs else { return }
            if let index = gesture.view?.tag {
                let appUrl = "mailto:\(contacts[index].value)"
                if let url = URL(string: appUrl), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "التواصل معالادارة العامة "
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
