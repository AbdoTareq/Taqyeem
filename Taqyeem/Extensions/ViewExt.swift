import Foundation
import UIKit

extension UIView
{
    func loadNib(name: String? = nil) -> UIView
    {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: name ?? nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

    class func fromNib<T: UIView>(name: String) -> T
    {
        return Bundle.main.loadNibNamed(String(describing: name), owner: nil, options: nil)![0] as! T
    }

        @IBInspectable var masksToBounds: Bool {
            get {
                return layer.masksToBounds
            }
            set {
                layer.masksToBounds = newValue
            }
        }
}

extension UIView {
    static func getAllSubviews(vw: UIView) -> [UIView] {
        var subviews = [UIView]()
        for vw in vw.subviews {
            subviews += getAllSubviews(vw: vw)
            subviews.append(vw)
        }
        return subviews
    }

    // corner radius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return 10
        } set {
            layer.cornerRadius = newValue
        }
    }

    // border width
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }

    // border width
    @IBInspectable
    var borderColor: UIColor {
        get {
            return self.borderColor
        } set {
            layer.borderColor = newValue.cgColor
        }
    }
    func renderSnapshot() -> UIView {
        let shadowOpacity = layer.shadowOpacity
        layer.shadowOpacity = 0 // avoid capturing shadow bits in bounds
        
        let snapshot = UIImageView(image: UIGraphicsImageRenderer(bounds: bounds).image { context in
            layer.render(in: context.cgContext)
        })
        layer.shadowOpacity = shadowOpacity
        
        if let shadowPath = layer.shadowPath {
            snapshot.layer.shadowPath = shadowPath
            snapshot.layer.shadowColor = layer.shadowColor
            snapshot.layer.shadowOffset = layer.shadowOffset
            snapshot.layer.shadowRadius = layer.shadowRadius
            snapshot.layer.shadowOpacity = layer.shadowOpacity
        }
        return snapshot
    }
    @objc func addShadow(color: UIColor, radius: CGFloat = 5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.4
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}
