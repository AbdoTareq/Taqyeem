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
    var about: HelpVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        vwContainer.addShadow(color: UIColor.darkGray)
        initNavigationBar()
        getData()
    }
    func getData() {
        HelpVM.get(type: 4) {help, error in
            if help != nil {
                self.about = help![0]
            } else {
                self.showAlert(message: error ?? "Failed to get data")
            }
            self.bindData()
        }
    }
    func bindData() {
        guard let about = about else { return }
        lblContent.text = about.text
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "نبذة عن الادارة العامة لصحة البيئة"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
