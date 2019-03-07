//
//  ObeidiAlertController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 20/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ObeidiAlertController: NSObject {
    
    class func showAlert(_ viewController: UIViewController, alertMessage: String) {
        
        viewController.view.alpha = 0.65
        let alertData = alertMessage
        let alert = UIAlertController(title: "Alert", message: alertData, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { action in
            viewController.view.alpha = 1.0
            
            
        }))
        viewController.present(alert, animated: true, completion: nil)
        
    }
    

}
