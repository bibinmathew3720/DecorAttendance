//
//  ObeidiSpinner.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 12/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ObeidiSpinner: NSObject {
    
    class func showSpinner(_ view: UIView, activityView:UIActivityIndicatorView){
        
        view.isUserInteractionEnabled = false
        activityView.center = view.center
        activityView.startAnimating()
        
        //view.alpha = 0.65
        view.addSubview(activityView)
        
    }
    class func hideSpinner(_ view: UIView, activityView: UIActivityIndicatorView) {
        
        view.alpha = 1.0
        view.isUserInteractionEnabled = true
        activityView.stopAnimating()
        
    }
    
    
}
