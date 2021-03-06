//
//  Constants.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 3/14/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

struct Constant{
    static let AppName = "Obaid Al Abdi"
    static let OneSignalAppId = "dd140ece-75a8-4890-8d24-2cbb2b81611c"
    
    struct PageNames {
        static let Attendance = "ATTENDANCE"
        static let Profile = "PROFILE"
        static let AboutUs = "ABOUT US"
        static let ChangePassword = "CHANGE PASSWORD"
        static let Dashboard = "DASHBOARD"
        static let SuspiciousEntries = "SUSPICIOUS ENTRIES"
    }
    struct ImageNames {
        static let placeholderImage = "placeholder"
        static let backArrow = "back"
    }
    
    struct VariableNames {
        static let isLoggedIn = "isLoggedIn"
        static let roleKey = "role"
        static let employeeId = "EmpID"
        
    }
    
    struct Names {
        static let EngineeringHead = "Engineering Head"
        static let Foreman = "Foreman"
        static let Staff = "staff"
        static let ExpirationStatusKey = "x-grace-period-status"
    }
    
    struct SegueIdentifiers {
        static let  labourWisetoLabourSummary = "labourWiseToLabourSummary"
        static let AttendanceCompletedListToDetail = "completedEntryListToCompletedEntryDetail"
        static let forgotToOTP = "forgotToOTP"
    }
    
    struct Colors {
        static let remainingBonusColor = UIColor(red:0.96, green:0.54, blue:0.14, alpha:1.0) //F58A23 - Light Orange Color
        static let overTimeColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1.0) //E92E2F - Red Color
        static let bonusColor = UIColor.blue //
        static let wageColor = UIColor(red:0.49, green:0.83, blue:0.13, alpha:1.0) //7ED321 - Green Color
        static let sickLeaveColor = UIColor(red:0.43, green:0.00, blue:0.49, alpha:1.0) //6E007C - Violet Color
        static let paidVacancColor = UIColor(red:0.92, green:0.75, blue:0.04, alpha:1.0) //EABE0B - Yellow Color
        
        static let greyColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0) //D8D8D8
        static let ashColor = UIColor(red:0.28, green:0.28, blue:0.28, alpha:1.0) //484747
        static let blackColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0) //000000
        static let whiteColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0) //FFFFFF
        
        static let commonRedColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1.0) //E92E2F - Red Color
        static let commonGreenColor = UIColor(red:0.49, green:0.83, blue:0.13, alpha:1.0)//7ED321 - Green Color
    }
    
    struct Font {
        static let AvenirBook = "Avenir Book"
    }
}
