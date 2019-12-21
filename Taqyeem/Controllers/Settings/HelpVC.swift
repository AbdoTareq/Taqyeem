//
//  HelpVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/30/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var vwContainer: UIView!
    var help: HelpVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        getData()
        vwContainer.addShadow(color: UIColor.gray)
    }
    func getData() {
        self.startLoadingActivity()
        HelpVM.get(type: 1) {help, error in
            self.stopLoadingActivity()
            if help != nil {
                self.help = help![0]
            } else {
                self.showAlert(message: error ?? "Failed to get data")
            }
            self.bindData()
        }
    }
    func bindData() {
        guard let help = help else { return }
        lblContent.text = help.text
    }
    
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "المساعدة"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
