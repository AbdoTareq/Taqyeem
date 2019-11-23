import Foundation
import UIKit

class ExtendedView:UIView,GradientProtocol,CircleP
{
 
    var gradient = CAGradientLayer()
 
    @IBInspectable var gX1: Double = 0
    @IBInspectable var gY1: Double = 0
    @IBInspectable var gX2: Double = 0
    @IBInspectable var gY2: Double = 0
    
    @IBInspectable var horizontalGradient:Bool  = false
    @IBInspectable var customGradient: Bool = false
    @IBInspectable var gradientColorOne:UIColor = .clear
    @IBInspectable var gradientColorTwo:UIColor = .clear
    @IBInspectable var gradientBorder:Bool = false
    {
        didSet
        {
           configureGradient(gradientBorder)
        }
    }
    @IBInspectable var makeCircle:Bool = false
    {
        didSet
        {
            configureCircle()
        }
    }
    
    @IBInspectable var gradientBackground:Bool = false
    {
        didSet
        {
            configureGradient(gradientBackground)
        }
    }
    
  
    
}


