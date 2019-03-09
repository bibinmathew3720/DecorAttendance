//
//  UIImageViewExtensions.swift
//  CCLUB
//
//  Created by Albin Joseph on 3/13/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import UIKit
import Foundation

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String, colorValue tintColor:UIColor?) {
        if urlString.isEmpty{
            print("---------------------EMPTY EMPTY----------------")
        }else{
            let url = URL(string: urlString)
            self.image = nil
            
            // check cached image
            if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
                self.image = cachedImage
                if let _color = tintColor{
                  self.changePngColorTo(color: _color)
                }
                return
            }
            
            // if not, download image from url
            if let imageUrl = url {
                URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data!) {
                            imageCache.setObject(image, forKey: urlString as NSString)
                            self.image = image
                            if let _color = tintColor{
                                self.changePngColorTo(color: _color)
                            }
                        }
                    }
                    
                }).resume()
            }
        }
        
    }
    func changePngColorTo(color: UIColor){
        guard let image =  self.image else {
            return
            
        }
        self.image = image.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}

//MARK:- UIImage Extension
extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint(x: 10,y :size.height - lineHeight), size: CGSize(width: size.width - 20, height: lineHeight)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
       // return UIImage(named: "tabIndicator")!
    }
    
    func yellowGradientImage(bounds:CGRect) -> UIImage
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: (202 / 255.0), green: (197 / 255.0), blue: (52 / 255.0), alpha: 1.0).cgColor, UIColor(red: (253 / 255.0), green: (248 / 255.0), blue: (101 / 255.0), alpha: 1.0).cgColor]
        gradientLayer.bounds = bounds
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        gradientLayer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


