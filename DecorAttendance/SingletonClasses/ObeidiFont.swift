//
//  ObeidiFont.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 19/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import Foundation
import AVKit

struct ObeidiFont {
    
    struct Size {
        static func smallA() -> CGFloat  {
            return 10
        }
        static func smallB() -> CGFloat  {
            return 12
        }
        static func mediumA() -> CGFloat  {
            return 14
        }
        static func mediumB() -> CGFloat  {
            return 16
        }
        static func bigA() -> CGFloat  {
            return 20
        }
        static func bigB() -> CGFloat  {
            return 30
        }
    }
    struct Family {
        static func normalFont() -> String  {
            return "Avenir"
        }
        static func lightFont() -> String  {
            return "Avenir-Light"
        }
        static func boldFont() -> String  {
            return "Avenir-Heavy"
        }
    }
    struct Color {
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
    }
}

//print all font names
//for fmlyName in UIFont.familyNames
//{
//    print(fmlyName)
//    for fntName in UIFont.fontNames(forFamilyName: fmlyName)
//    {
//        print(fntName)
//    }
//    print("-------------")
//}

//Avenir
//Avenir-Oblique
//Avenir-HeavyOblique
//Avenir-Heavy
//Avenir-BlackOblique
//Avenir-BookOblique
//Avenir-Roman
//Avenir-Medium
//Avenir-Black
//Avenir-Light
//Avenir-MediumOblique
//Avenir-Book
//Avenir-LightOblique
//Academy Engraved LET
//AcademyEngravedLetPlain
