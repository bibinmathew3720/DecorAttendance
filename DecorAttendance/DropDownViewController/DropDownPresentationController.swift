//
//  DropDownPresentationController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 18/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class DropDownPresentationController: UIPresentationController {
    
    
    func frameOfPresentedViewInContainerView() -> CGRect {
//        return CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: containerView!.bounds.height/2)
        return CGRect(x: 10, y: 140, width: 8, height: 10)
    }

}
