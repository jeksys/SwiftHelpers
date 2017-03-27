import Foundation
import UIKit

@available(*, deprecated, message: "unimplemented ")
var TODO: Never{
    fatalError("unimplemented")
}
@available(*, deprecated, message: "Fix this")
var FIXME: Void{ return }

extension UIView {
    func layerGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint(x: 0, y: 0)
        
        let color1 = UIColor.white.withAlphaComponent(0.1).cgColor
        let color2 = UIColor.white.withAlphaComponent(1.0).cgColor
        
        layer.colors = [color1, color2]
        self.layer.insertSublayer(layer, at: 0)
    }
}

func convertImageToBW(image:UIImage) -> UIImage {
    let filter = CIFilter(name: "CIPhotoEffectMono")
    let ciInput = CIImage(image: image)
    filter?.setValue(ciInput, forKey: "inputImage")
    
    // get output CIImage, render as CGImage first to retain proper UIImage scale
    let ciOutput = filter?.outputImage
    let ciContext = CIContext()
    let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
    
    return UIImage(cgImage: cgImage!)
}

extension UIViewController{
    
    func present(withNavigation viewController: UIViewController, isToolbarHidden: Bool = false){
        let recordNC = MainViewController(rootViewController: viewController)
        recordNC.navigationBar.barStyle = .black
        recordNC.navigationBar.isTranslucent = false
        recordNC.navigationBar.tintColor = .white
        recordNC.isToolbarHidden = isToolbarHidden
        recordNC.toolbar.isTranslucent = false
        recordNC.toolbar.barStyle = .black
        self.navigationController?.present(recordNC, animated: true)
    }

}


extension UIImage {
    
    /// Returns a image that fills in newSize
    func resizedImage(newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Returns a resized image that fits in rectSize, keeping it's aspect ratio
    /// Note that the new image size is not rectSize, but within it.
    func resizedImageWithinRect(rectSize: CGSize) -> UIImage {
        let widthFactor = size.width / rectSize.width
        let heightFactor = size.height / rectSize.height
        
        var resizeFactor = widthFactor
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
        let resized = resizedImage(newSize: newSize)
        return resized
    }
    
}

extension String {
    func appendingPathComponent(_ string: String) -> String {
        return URL(fileURLWithPath: self).appendingPathComponent(string).path
    }
}

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

extension UIViewController{

    func showMessage(_ title: String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showAlert(message:String){
        let alert = UIAlertController(title: "Alert".localized, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showError(message:String){
        let alert = UIAlertController(title: "Error".localized, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: UIAlertActionStyle.cancel))
        self.present(alert, animated: true, completion: nil)
    }

}


extension Bundle{

    class var versionString : String {
        get{
            if let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleShortVersionString"] as? String, let build = dictionary["CFBundleVersion"] as? String{
                return "\(version).\(build)"
            }
            return ""
        }
    }
    class var versionStringShort : String {
        get{
            if let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleShortVersionString"] as? String{
                return "\(version)"
            }
            return ""
        }
    }

}



/**
 Executes the closure on the main queue after a set amount of seconds.
 */
func delayOnMainQueue(delay: Double = 0, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

/**
 Executes the closure on a background queue after a set amount of seconds.
 */
func delayOnBackgroundQueue(delay: Double = 0, closure: @escaping ()->()) {
    DispatchQueue.global().asyncAfter(deadline: .now() + delay){
        closure()
    }
}

var GlobalMainQueue: DispatchQueue {
    return DispatchQueue.main
}

var GlobalUserInteractiveQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
}

var GlobalUserInitiatedQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
}

var GlobalUtilityQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
}

var GlobalBackgroundQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
}

extension String {
    var hex: Int? {
        return Int(self, radix: 16)
    }
}
extension UIColor {
    convenience init(hex: Int) {
        self.init(hex: hex, a: 1.0)
    }
    
    convenience init(hex: Int, a: CGFloat) {
        self.init(r: (hex >> 16) & 0xff, g: (hex >> 8) & 0xff, b: hex & 0xff, a: a)
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r: r, g: g, b: b, a: 1.0)
    }
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    convenience init?(hexString: String) {
        guard let hex = hexString.hex else {
            return nil
        }
        self.init(hex: hex)
    }
}

public extension UIDevice {
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone35
        case iPhone4
        case iPhone47
        case iPhone55
        case iPad
        case iPadPro
        case Unknown
    }
    
    var screenType: ScreenType {
        let maxDimenshion = max(UIScreen.main.nativeBounds.height, UIScreen.main.nativeBounds.width)
        switch maxDimenshion {
        case 960:
            return .iPhone35
        case 1136:
            return .iPhone4
        case 1334:
            return .iPhone47
        case 1920:
            return .iPhone55
        case 2208:
            return .iPhone55
        case 2048:
            return .iPad
        case 2732:
            return .iPadPro
        default:
            return .Unknown
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
