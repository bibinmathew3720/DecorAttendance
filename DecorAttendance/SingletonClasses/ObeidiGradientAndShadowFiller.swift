//
//  ObeidiGradientAndShadowFiller.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 16/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//
import UIKit

extension UIView {
    
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 2
        
        //layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        //layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8).cgPath//UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func applyCustomGradient(colors: [CGColor]) {
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        gradient.colors = colors
        gradient.locations = [0, 0.41519666, 0.782474, 1]
        gradient.startPoint = CGPoint(x: 0.02, y: 0.04)
        gradient.endPoint = CGPoint(x: 1.21, y: 1.45)
        self.layer.addSublayer(gradient)
        
        
    }
    
}
