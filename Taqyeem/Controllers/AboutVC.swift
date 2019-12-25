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
    var about: [HelpVM]?
    override func viewDidLoad() {
        super.viewDidLoad()
        vwContainer.addShadow(color: UIColor.darkGray)
        initNavigationBar()
        getData()
    }
    func getData() {
        self.startLoadingActivity()
        HelpVM.get(type: 4) {help, error in
            self.stopLoadingActivity()
            if help != nil {
                self.about = help!
            } else {
                self.showAlert(message: error ?? "Failed to get data")
            }
            self.bindData()
        }
    }
    func bindData() {
        guard let about = about else { return }
        
        let attribute: NSAttributedString = {
            let attributedString = NSMutableAttributedString()
            for item in about {
                if item.isHeader == 1 {
                    attributedString.append(NSAttributedString(string: "■ \(item.text) \n\n", attributes: [
                        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
                        NSAttributedString.Key.foregroundColor: UIColor(hexString: "#CCA121")
                    ]))
                } else {
                    attributedString.append(NSAttributedString(string: "      ■ \(item.text) \n\n", attributes: [
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                        NSAttributedString.Key.foregroundColor: UIColor(hexString: "#CCA121")
                    ]))
                }
            }
            return attributedString
        }()
        lblContent.attributedText = attribute
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
