//
//  ObeidiButtonStyle.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 31/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ObeidiButtonStyle: NSObject {
    
    class func setNotWornSafetyButtonTheme(button: UIButton){
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = ObeidiColors.ColorCode.obeidiButtonAsh()
        
    }
    class func setWornSafetyButtonTheme(button: UIButton){
        button.layer.cornerRadius = button.frame.size.height / 2
        
        button.backgroundColor = ObeidiColors.ColorCode.obeidiLineGreen()
        
    }

}
