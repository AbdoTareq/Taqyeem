//
//  CircleImage.swift
//  Laundry
//
//  Created by Mostafa on 8/10/17.
//  Copyright © 2017 Mostafa. All rights reserved.
//

import UIKit

private var CircleKey = false

extension UIView {
    @IBInspectable var circleDesign: Bool {
        get {
            return CircleKey
        }
        set {
            CircleKey = newValue
            if CircleKey {
                // self.layer.masksToBounds = true
                clipsToBounds = true
                layer.cornerRadius = frame.size.height / 2
                // self.layer.borderWidth = 1.0
                // self.layer.borderColor = UIColor.white.cgColor
            }
            else {
                layer.cornerRadius = 0
            }
        }
    }

    func makeCircle() {
        layer.masksToBounds = false
        
        layer.cornerRadius = frame.size.height / 2
    
        clipsToBounds = true
        
    }

    func makeCircleWithBoarder() {
        clipsToBounds = true
        layer.cornerRadius = frame.size.height / 2
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
