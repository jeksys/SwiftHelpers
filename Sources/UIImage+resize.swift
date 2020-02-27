//
//  ViewController.swift
//  ImageCropper
//
//  Created by Evgeny Yagrushkin on 2017-08-03.
//  Copyright © 2017 Evgeny Yagrushkin. All rights reserved.
//
import UIKit


extension UIImage {
    
    public func resize(to sizeMB: Float) -> UIImage? {
        
        if let data = self.jpegData(compressionQuality: 0.9){
            let size = Float(data.count)
            let percentage = sizeMB / (size/1024/1024)
            return self.resizeWithPercent(percentage: CGFloat(percentage))
        }
        
        return nil
    }

    public func resize(toSize size: CGSize) -> UIImage? {
        let scale = size.width / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: size.width, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: newHeight))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result

    }

    // ration width/hight
    public func fit(withRatio ratio: CGFloat, backgroundColor: UIColor = UIColor.black) -> UIImage? {
        
        let width = self.size.width
        let height = width * 1/ratio
        
        let frameSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(frameSize, true, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        backgroundColor.setFill()
        let fillRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        context.fill(fillRect)
        let imageRect = CGRect(x: 0, y: (frameSize.height-self.size.height)/2, width: self.size.width, height: self.size.height)
        draw(in: imageRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        
        let percentage = percentage > 1 ? 1.0 : percentage
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
}
