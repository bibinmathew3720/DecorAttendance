//
//  File.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 16/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import Foundation
@objc
protocol CenterViewControllerDelegate {
    
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSidePanel()
    
    
}
