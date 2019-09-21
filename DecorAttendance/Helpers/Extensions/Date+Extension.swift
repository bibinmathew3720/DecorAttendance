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
        let components = calendar.dateComponents([.hour,.minute,.second,.month,.year], from: self)
        return components
    }
    
    func stringFromDate(format:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
