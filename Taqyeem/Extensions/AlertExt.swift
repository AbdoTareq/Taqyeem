//
//  AlertExt.swift
//  Reach Plus
//
//  Created by Mostafa sayed on 7/31/19.
//  Copyright © 2019 Reach. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    @objc func showAlert(title: String? = "", message: String, buttonTitle: String? = "حسنا") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
