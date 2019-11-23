//
//  SpinnerExt.swift
//  Reach_Network
//
//  Created by Sameh sayed on 6/23/19.
//  Copyright © 2019 Reach. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import UIKit

extension UIView {
    func startLoadingActivity() {
        let data = ActivityData(size: nil, message: nil, messageFont: nil, messageSpacing: nil, type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(data, nil)
    }

    func stopLoadingActivity() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}

extension UIViewController {
    func startLoadingActivity() {
        view.startLoadingActivity()
    }

    func stopLoadingActivity() {
        view.stopLoadingActivity()
    }
}
