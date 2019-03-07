//
//  ForemanCenterViewControllerDelegate.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 05/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import Foundation
@objc
protocol ForemanCenterViewControllerDelegate {
    
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSidePanel()
    
    
}

