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
        
        //static let MAIN_DOMAIN = "http://172.104.61.150:8080/" //Test Server
        static let MAIN_DOMAIN = "https://api.hkbsolution.com/" //Production Server
        static let ABOUT = "meta"
        static let LOGIN = "auth/login"
        static let PROFILE = "profile"
        static let EMPLOYEES = "employees?"
        static let EMPLOYEEDETAIL = "employees"
        static let RESET_PASSWORD = "auth/send-reset-password"
        static let CHANGE_PASSWORD = "auth/change-password"
        static let VERIFY_OTP = "auth/access-token"
        static let GET_ALL_SITES = "sites"
        static let COST_SUMMARY_SITEWISE = "reports/cost-summary-sitewise?"
        static let ACCESS_TOKEN = "auth/access-token?"
        static let COST_SUMMARY_LABOURWISE = "reports/cost-summary-labourwise?"
        static let COST_SUMMARY_LABOURWISE_DETAIL = "reports/cost-summary-labourwise/detail/"
        static let SAFETY_EQUIPMENTS = "safety-equipments"
        static let FETCH_ATTENDANCE = "attendance?"
        static let MARK_ATTENDANCE = "attendance"
        static let MARK_ATTENDANCE_FOR_STAFF = "staff/attendance"
        static let GET_ATTENDANCE_DETAIL = "attendance/"
        static let UPDATE_ATTENDANCE_STATUS = "attendance/change-attendance-status"
        static let UPDATE_BONUS_AMOUNT = "attendance/update-bonus"
        
        //Forman
        
         static let ATTENDANCE_SUMMARY = "attendance/attendance-summary?"
        
        //For Staff
        
        static let STAFF_ATTENDANCE_LIST_URL = "staff/leaves-for-period?"
        static let STAFF_MEDICAL_ATTENDANCE_LIST_URL = "staff/medical-leaves?"
        static let REPORT_LISTING_URL = "staff/attendance-for-period?"
        
    }
    
    
}
