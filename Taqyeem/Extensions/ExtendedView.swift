import Foundation
import UIKit

class ExtendedView:UIView,CircleP
{
    @IBInspectable var makeCircle:Bool = false
    {
        didSet
        {
            configureCircle()
        }
    }
}


