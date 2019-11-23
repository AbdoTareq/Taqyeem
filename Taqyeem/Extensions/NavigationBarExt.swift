//
//  NavigationBarExt.swift
//  Trolly
//
//  Created by sameh on 9/4/18.
//  Copyright © 2018 soleek. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    open override func awakeFromNib() {
        // remove back button text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backBarButtonItem = backItem
    }
}

extension UINavigationController {
    // func defaultStyle(withLine: Bool = true) {
    //        // removes down line
    //        navigationBar.shadowImage = withLine ? UINavigationController().navigationBar.shadowImage : UIImage()
    //
    ////        applyShaddow()
    //        backButton()
    //        lightFont()
    //        applyColor()
    //        removeBackText()
    //    }

    func transparent(black: Bool = true) {
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        black ? backButton() : whiteBackButton()
    }

    private func whiteBackButton() {
        let backImage = UIImage(named: "back-8")
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.tintColor = .clear
    }

    func defaultStyle() {
        let _nav = UINavigationBar()
        navigationBar.isTranslucent = _nav.isTranslucent
        navigationBar.setBackgroundImage(_nav.backgroundImage(for: .default), for: .default)
        navigationBar.shadowImage = _nav.shadowImage
    }

    private func applyColor() {
        navigationBar.setBackgroundImage(
            UINavigationController().navigationBar.backgroundImage(for: .any, barMetrics: .default), for: .default
        )
        navigationBar.barTintColor = .white
    }

    private func backButton() {
        let backImage = UIImage(named: "back_ic")
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.tintColor = .clear
    }

    func lightFont() {
        //        navigationBar.titleTextAttributes = [.font: UIFont.custom(font: .monMedium, size: 15),.foregroundColor: UIColor.white]
    }

    func blackFont() {
        //        navigationBar.titleTextAttributes = [.font: UIFont.custom(font: .monBold, size: 17),.foregroundColor: UIColor.black]
    }

    func removeBackText() {
        topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
