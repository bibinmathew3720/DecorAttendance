//
//  User.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 24/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import Foundation

struct User {
    
    enum attendanceType {
        case startTime
        case endTime
        case sickLeave
        case strike
        
    }
    
    struct Attendance {
        
        static var type = User.attendanceType.startTime
        
    }
    struct BonusDetails {
        
        static var bonus_budget = ""
        static var remaining_bonus = ""
        
    }
    
    
}
//sick_leave,end_time,start_time,strike,absent
