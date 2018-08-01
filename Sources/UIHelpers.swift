import Foundation
import UIKit

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

extension UIScrollView{
    
    func makeVisible(view: UIView, margin: CGFloat = 15, animated: Bool = false) {
        if view.superview == self{
            var frame = view.frame
            frame.size.height = frame.size.height + margin
            self.scrollRectToVisible(frame, animated: animated)
        }
    }
    
}

extension UIViewController{
    
    func showAskText(_ title: String?, text:String?, actionTitle: String? = "general.ok".localized, completion: ((String?)->Void)? = nil){
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "general.cancel".localized, style: .cancel, handler: { (action: UIAlertAction!) in
            completion?(nil)
        }))
        
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action: UIAlertAction!) in
            let text = alertController.textFields?.first?.text
            completion?(text)
        }))
        
        alertController.addTextField { (textField) -> Void in
            textField.text = text
        }
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func showMessage(_ title: String, message:String, completion: (()->Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "general.ok".localized, style: .default, handler: { (action: UIAlertAction!) in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDeleteAlert(_ title: String?, message:String?, completion: (()->Void)? = nil){
        let deleteAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        deleteAlert.addAction(UIAlertAction(title: "Delete".localized, style: .destructive, handler: { (action: UIAlertAction!) in
            completion?()
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "general.cancel".localized, style: .cancel))
        present(deleteAlert, animated: true, completion: nil)
    }

    func showConfirmActionAlert(_ title: String?, message:String?, actionTitle: String?, completion: (()->Void)? = nil){
        let confirmAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        confirmAlert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action: UIAlertAction!) in
            completion?()
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "general.cancel".localized, style: .cancel))
        present(confirmAlert, animated: true, completion: nil)
    }
    
    func showAlert(message:String, completion: (()->Void)? = nil){
        delayOnMainQueue {
            let alert = UIAlertController(title: "general.alert".localized, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "general.ok".localized, style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                completion?()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func showTODO(message:String){
        delayOnMainQueue {
            let alert = UIAlertController(title: "TODO. Feature is under development".localized, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "general.ok".localized, style: UIAlertActionStyle.default))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func showError(message:String, completion: (()->Void)? = nil){
        delayOnMainQueue {
            let alert = UIAlertController(title: "general.error".localized, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "general.ok".localized, style: UIAlertActionStyle.cancel , handler: { (action: UIAlertAction!) in
                completion?()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showError(error:Error, completion: (()->Void)? = nil){
        delayOnMainQueue {
            let alert = UIAlertController(title: "general.error".localized, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "general.ok".localized, style: UIAlertActionStyle.cancel, handler: { (action: UIAlertAction!) in
                completion?()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showConnectionError(message:String){
        delayOnMainQueue {
            let messageConnection = "Please check your internet connection to continue".localized
            let alert = UIAlertController(title: "You are offline".localized, message: messageConnection, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "general.ok".localized, style: UIAlertActionStyle.cancel))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    var alertStyle: UIAlertControllerStyle{
        get{
            let style: UIAlertControllerStyle
            if(UIDevice.current.userInterfaceIdiom == .pad){
                style = .alert
            }else{
                style = .actionSheet
            }
            return style
        }
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

extension UIColor {
    // Returns the inverse color
    var inverseColor: UIColor{
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return self
    }
}

extension CGRect {
    public mutating func offsetInPlace(dx: CGFloat, dy: CGFloat) {
        self = offsetBy(dx: dx, dy: dy)
    }
}
