//
//  ObeidiConstants.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 12/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import Foundation

struct ObeidiConstants {
    
    struct API {
        
        static let MAIN_DOMAIN = "http://172.104.61.150:8080/"
        static let LOGIN = "auth/login"
        static let PROFILE = "profile"
        static let RESET_PASSWORD = "auth/send-reset-password"
        static let CHANGE_PASSWORD = "auth/change-password"
        static let GET_ALL_SITES = "sites"
        static let COST_SUMMARY_SITEWISE = "reports/cost-summary-sitewise"
        static let ACCESS_TOKEN = "auth/access-token?"
        static let COST_SUMMARY_LABOURWISE = "reports/cost-summary-labourwise"
        static let SAFETY_EQUIPMENTS = "safety-equipments"
        static let FETCH_ATTENDANCE = "attendance"
        static let MARK_ATTENDANCE = "attendance"
        
    }
    
    
}
