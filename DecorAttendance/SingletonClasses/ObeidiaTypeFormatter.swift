//
//  ObeidiaTypeFormatter.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 14/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ObeidiaTypeFormatter: NSObject {
    
    class func stringFromCGFloat(floatVal: CGFloat) -> String{
        
        //let f = -33.861382
        let s = NSString(format: "%.0f", floatVal)
        
        //        let nf = NumberFormatter()
        //        nf.numberStyle = .DecimalStyle
        //        // Configure the number formatter to your liking
        //        let s2 = nf.stringFromNumber(f)
        return s as String
        
    }
    class func cgfloatFromString(str: String) -> CGFloat{
        
        var f = CGFloat()
        if let n = NumberFormatter().number(from: str) {
            f = CGFloat(truncating: n)
            
        }
        return f
    }
    

}
