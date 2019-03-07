////
////  DateValueFormattter.swift
////  DecorAttendance
////
////  Created by Sreejith n  krishna on 16/12/18.
////  Copyright © 2018 Sreeith n  krishna. All rights reserved.
////
////
//
//import Foundation
//import Charts
//
//public class DateValueFormatter: NSObject, IAxisValueFormatter {
//    private let dateFormatter = DateFormatter()
//    
//    override init() {
//        super.init()
//        dateFormatter.dateFormat = "dd MMM HH:mm"
//    }
//    
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
//    }
//}
