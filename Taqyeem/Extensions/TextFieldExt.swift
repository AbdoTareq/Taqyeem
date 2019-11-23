//
//  textFieldExt.swift
//  Reach Plus
//
//  Created by Mostafa sayed on 7/31/19.
//  Copyright © 2019 Reach. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    // set attributed text for text field
    @objc func setAttributedPlaceholder(forString string: String, withColor color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    // padding
    @IBInspectable var padding: CGFloat {
        get {
            return self.padding
        }
        set {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.height))
            leftView = view
            leftViewMode = .always
            rightView = view
            rightViewMode = .always
        }
    }
    
    // add bottom border
    func addBottomBorder(withColor color: UIColor) {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
    }
}
