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
