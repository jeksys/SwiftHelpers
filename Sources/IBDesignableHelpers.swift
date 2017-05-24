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
        let attributedText =  NSAttributedString(string: self.titleLabel!.text!, attributes: [NSKernAttributeName:kerningValue, NSFontAttributeName:self.titleLabel!.font, NSForegroundColorAttributeName:self.titleLabel!.textColor])
        self.setAttributedTitle(attributedText, for: .normal)
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
        self.attributedText =  NSAttributedString(string: self.text ?? "", attributes: [NSKernAttributeName:kerningValue, NSFontAttributeName:font, NSForegroundColorAttributeName:self.textColor])
    }
}
