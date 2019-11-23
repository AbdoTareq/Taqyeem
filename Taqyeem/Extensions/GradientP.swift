//
//  GradientP.swift
//  Yamam
//
//  Created by sameh on 5/22/18.
//  Copyright © 2018 soleek. All rights reserved.
//

import Foundation
import UIKit

protocol GradientProtocol:class
{
    var gradient:CAGradientLayer { get set }
    var horizontalGradient:Bool  {get set }
    var customGradient:Bool { get set }
    var gradientColorOne:UIColor {get set}
    var gradientColorTwo:UIColor {get set}
    var gX1:Double {get set}
    var gY1:Double {get set}
    var gX2:Double {get set}
    var gY2:Double {get set}
    var gradientBorder:Bool {get set}
    var gradientBackground:Bool {get set}

    func gradientLayout()
}

extension GradientProtocol where Self:UIView
{
    func configureGradient(_ type:Bool)
    {
        if type
        {
            gradient.colors = [gradientColorOne.cgColor, gradientColorTwo.cgColor]
        }
    }
    
    func gradientLayout()
    {
        if gradientBorder
        {
            gradient.removeFromSuperlayer()
            makeGradientBorder(gradient)
        }
        
        if gradientBackground
        {
            gradient.removeFromSuperlayer()
            makeGradientBackground(horizontal: horizontalGradient)
        }
    }

    func makeGradientBackground(horizontal:Bool)
    {
        let grad:CAGradientLayer =
        {
            let gradient = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = [gradientColorOne,gradientColorTwo].map { $0.cgColor }
            let customOrientation = (CGPoint(x: gX1, y: gY1),CGPoint(x: gX2, y: gY2))
            let orientation = customGradient ? customOrientation : (horizontal) ?
                (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
                :(CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
            
            gradient.startPoint = orientation.0
            gradient.endPoint = orientation.1
            return gradient
        }()
        
        self.layer.insertSublayer(grad, at: 0)
    }
    
    func makeGradientBorder(_ gradColors:CAGradientLayer)
    {
        let gradient:CAGradientLayer =
        {
            let gradient = CAGradientLayer()
            gradient.colors = [gradientColorOne,gradientColorTwo].map { $0.cgColor }
            gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
            gradient.colors = gradColors.colors
            return gradient
        }()
        
        let shape:CAShapeLayer =
        {
            let shape = CAShapeLayer()
            shape.lineWidth = 4
            shape.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            return shape
        }()
        
        gradient.mask = shape
        self.layer.addSublayer(gradient)
    }

}
