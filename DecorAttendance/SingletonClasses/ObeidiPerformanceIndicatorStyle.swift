//
//  ObeidiPerformanceIndicatorStyle.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 19/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ObeidiPerformanceIndicatorStyle: NSObject {
    
    class func setIndicatorsByValues(lineA: UIView, lineB: UIView, lineAColor: UIColor, lineBColor: UIColor, lineAValue: CGFloat, lineBValue: CGFloat, lineAMeter: NSLayoutConstraint, lineBMeter: NSLayoutConstraint) {
        
        lineA.layer.cornerRadius = lineA.frame.size.height / 2
        lineB.layer.cornerRadius = lineB.frame.size.height / 2
        
        lineB.backgroundColor = lineBColor
        lineA.backgroundColor = lineAColor
        var lineAValVar = lineAValue
        var lineBValVar = lineBValue
        
        if lineAValVar.isNaN{
            
            lineAValVar = 0
        }
        if lineBValVar.isNaN{
            
            lineBValVar = 0
        }
        
        lineAMeter.constant = lineAValVar * lineA.frame.size.width
        lineBMeter.constant = lineBValVar * lineA.frame.size.width
    
    }
    

}
