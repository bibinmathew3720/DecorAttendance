//
//  ObeidiColors.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 19/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import Foundation
import AVKit

struct ObeidiColors {
    
    struct Gradients {
        static func topBarRedGradients() -> [CGColor]  {
            return [UIColor(red:1, green:0, blue:0.09, alpha:1).cgColor,    UIColor(red:0.79, green:0.01, blue:0.1, alpha:1).cgColor,    UIColor(red:0.68, green:0.01, blue:0.11, alpha:1).cgColor,    UIColor(red:0.62, green:0.02, blue:0.11, alpha:1).cgColor]
        }
       
    }
    struct ColorCode {
        
        static func obeidiLineGreen() -> UIColor  {
             return ObeidiColorMeter.hexStringToUIColor(hex: "#7ED321")
        }
        static func obeidiMediumBlack() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#4A4A4A")
            
        }
        static func obeidiExactBlack() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#000000")
            
        }
        static func obeidiLightBlack() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#9B9B9B")
            
        }
        static func obeidiExactWhite() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#FFFFFF")
            
        }
        static func obeidiLineRed() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#E92E2F")
            
        }
        static func obeidiLinePink() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#E91E63")
            
        }
        static func obeidiLineOrange() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#FF7F00")
            
        }
        static func obeidiLineWhite() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#D8D8D8")
            
        }
        static func obeidiPink() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#E91E7E")
            
        }
        static func obeidiTonedPink() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#E91E63")
            
        }
        static func obeidiDarkOrange() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#F56B23")
            
        }
        static func obeidiLightOrange() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#F58A23")
            
        }
        static func obeidiViolet() -> UIColor {
            return ObeidiColorMeter.hexStringToUIColor(hex: "#6E007C")
            
        }
        static func obeidiRed() -> UIColor {
            
            return ObeidiColorMeter.hexStringToUIColor(hex: "#E92E2F")
        }
        static func obeidiCircleAsh() -> UIColor {
            
            return ObeidiColorMeter.hexStringToUIColor(hex: "#484747")
        }
        static func obeidiButtonAsh() -> UIColor {
            
            return ObeidiColorMeter.hexStringToUIColor(hex: "#C0C0C0")
        }
    }
    
    struct ColorThemes {
        static func obeidiPieGraphShades() -> [CGColor] {
            
            return [ObeidiColors.ColorCode.obeidiRed().cgColor,  ObeidiColors.ColorCode.obeidiTonedPink().cgColor,  ObeidiColors.ColorCode.obeidiViolet().cgColor,  ObeidiColors.ColorCode.obeidiLightOrange().cgColor, ObeidiColors.ColorCode.obeidiDarkOrange().cgColor, ObeidiColors.ColorCode.obeidiPink().cgColor]
        }
    }
}
