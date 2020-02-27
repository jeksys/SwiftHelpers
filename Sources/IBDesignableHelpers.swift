import UIKit
import Foundation

@IBDesignable extension UIButton{
    
    @IBInspectable var borderColor: UIColor?{
        get {
            guard let color = layer.borderColor else{
                return nil
            }
            return UIColor(cgColor: color)
        }
        set{
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat{
        get {
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var cornerRadius: CGFloat{
        get {
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
    }
    
}

@IBDesignable extension UILabel{
    
    @IBInspectable var borderColor: UIColor?{
        get {
            guard let color = layer.borderColor else{
                return nil
            }
            return UIColor(cgColor: color)
        }
        set{
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat{
        get {
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var cornerRadius: CGFloat{
        get {
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
    }
    
}

@IBDesignable extension UIButton {

    @IBInspectable var kern: CGFloat{
        get {
            return 0
        }
        set{
            self.kern(kerningValue: newValue)
        }
    }
    
    func kern(kerningValue:CGFloat) {
        if let text = self.titleLabel!.text{
            let attributedString =  NSMutableAttributedString(attributedString: self.titleLabel!.attributedText ?? NSMutableAttributedString(string: text))
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kern, range: NSMakeRange(0, attributedString.length))
            self.setAttributedTitle(attributedString, for: .normal)
        }
    }
}

@IBDesignable extension UILabel {

    @IBInspectable var kern: CGFloat{
        get {
            return 0
        }
        set{
            self.kern(kerningValue: newValue)
        }
    }

    func kern(kerningValue:CGFloat) {
        if let text = self.text{
            let attributedString =  NSMutableAttributedString(attributedString: self.attributedText ?? NSMutableAttributedString(string: text))
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kern, range: NSMakeRange(0, attributedString.length))
            self.attributedText =  attributedString
        }
    }
}
