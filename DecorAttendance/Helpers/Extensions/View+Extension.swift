//
//  View+Extension.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/21/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

extension UIView{
    func setBorderProperties(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
    }
    
    func setRoundedRedBorder(){
        self.layer.borderWidth = 1
        self.layer.borderColor = Constant.Colors.commonRedColor.cgColor
        self.layer.cornerRadius = 10
    }
    
    func setRoundedRedBackgroundView(){
        self.layer.borderWidth = 1
        self.layer.borderColor = Constant.Colors.commonRedColor.cgColor
        self.backgroundColor = Constant.Colors.commonRedColor
        self.layer.cornerRadius = self.frame.size.height / 2
    }
}
