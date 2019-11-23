//
//  HomeStack.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
@IBDesignable
class HomeStack: UIStackView {
    @IBOutlet weak var vwFav: UIView!
    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var vwGeneralNews: UIView!
    @IBOutlet weak var vwManagementNews: UIView!
    @IBOutlet weak var vwEGate: UIView!
    @IBOutlet weak var vwAbout: UIView!
    
    @IBOutlet weak var stackFirst: UIStackView!
    @IBOutlet weak var stackSecond: UIStackView!
    @IBOutlet weak var stackThird: UIStackView!
    
    func roundCorners() {
        vwFav.layer.masksToBounds = true
        vwSearch.layer.masksToBounds = true
        vwGeneralNews.layer.masksToBounds = true
        vwManagementNews.layer.masksToBounds = true
        vwEGate.layer.masksToBounds = true
        vwAbout.layer.masksToBounds = true
        
        stackFirst.layer.masksToBounds = true
        stackSecond.layer.masksToBounds = true
        stackThird.layer.masksToBounds = true
    }
    
    @IBInspectable private var color: UIColor?
    override var backgroundColor: UIColor? {
        get { return color }
        set {
            color = newValue
            self.setNeedsLayout() // EDIT 2017-02-03 thank you @BruceLiu
        }
    }

    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = self.backgroundColor?.cgColor
    }
}
