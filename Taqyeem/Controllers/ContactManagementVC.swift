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
    @IBOutlet weak var constantTableHeight: NSLayoutConstraint!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblTwitter: UILabel!
    @IBOutlet weak var lblFacebook: UILabel!
    @IBOutlet weak var tablePhones: UITableView!
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
                lblFacebook.text = contact.value
                lblFacebook.tag = i
                let fbClicked = UITapGestureRecognizer(target: self, action: #selector(goTOFB))
                lblFacebook.addGestureRecognizer(fbClicked)
            } else if contact.type == 2 {
                lblEmail.text = contact.value
                lblEmail.tag = i
                let mailClicked = UITapGestureRecognizer(target: self, action: #selector(mail))
                lblEmail.addGestureRecognizer(mailClicked)
            }
        }
        tablePhones.reloadData()
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
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        guard let contactUs = contactUs else { return }
        let list = contactUs.filter{$0.type == 1}
        if list.count > 0 {
            self.constantTableHeight?.constant = self.tablePhones.contentSize.height
        }
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "التواصل مع الادارة العامة "
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
extension ContactManagementVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contactUs = contactUs else {return 0}
        return contactUs.filter{$0.type == 1}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablePhones.dequeueReusableCell(withIdentifier: "ContactManagementPhoneCell", for: indexPath) as! ContactPhoneCell
        let phones = contactUs!.filter{$0.type == 1}
        cell.lblPhone.text = phones[indexPath.row].value
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         self.viewWillLayoutSubviews()
    }
}
