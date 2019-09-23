//
//  Date+Extension.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/21/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

extension Date{
    
    func getComponents()->DateComponents{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour,.minute,.second,.month,.year,.day], from: self)
        return components
    }
    
    func stringFromDate(format:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func getStartDateOfYear()->Date{
        var monthComponent = DateComponents()
        if let _month = self.getComponents().month{
            monthComponent.month = 0 - _month + 1
        }
        let calendar = NSCalendar.current
        return calendar.date(byAdding: monthComponent, to:Date()) ?? self
    }
}
