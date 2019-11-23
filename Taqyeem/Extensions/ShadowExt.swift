//
//  ShadowExt.swift
//  GVS Teacher
//
//  Created by sameh on 8/4/18.
//  Copyright © 2018 Hussam Elsadany. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }

        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowX: CGFloat {
        get {
            return layer.shadowOffset.width
        }

        set {
            layer.shadowOffset.width = newValue
        }
    }

    @IBInspectable var shadowY: CGFloat {
        get {
            return layer.shadowOffset.height
        }

        set {
            layer.shadowOffset.height = newValue
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }

        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }

        set {
            layer.shadowColor = newValue.cgColor
        }
    }
}
