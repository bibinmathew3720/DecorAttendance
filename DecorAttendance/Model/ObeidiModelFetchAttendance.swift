//
//  ObeidiModelFetchAttendance.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 15/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit
import AFNetworking

@objcMembers

class ObeidiModelFetchAttendance: NSObject {
    var attendanceId:Int = 0
    var bonusAmount:CGFloat = 0.0
    var empId:Int = 0
    var endTimeMarkd:CGFloat = 0.0
    var endTimeMarkedAt:String = ""
    var endTimeMarkedBy:String = ""
    var profileImageUrl:String = ""
    var profileBaseUrl:String = ""
    var isApproved:Int = 0
    var isAttendanceCompleted:Int = 0
    var isPresent:Int = 0
    var isSickLeave:Int = 0
    var isStrike:Int = 0
    var isSuspicious:Int = 0
    var markedAt:String = ""
    var name:String = ""
    var siteId:Int = 0
    var startTimeMarked:CGFloat = 0.0
    var startTimeMarkedAt:String = ""
    var startTimeMarkedBy:String = ""
    
    init(dictionaryDetails : NSDictionary)
    {
        super.init()
        if let value = dictionaryDetails["attendance_id"] as? Int{
            attendanceId = value
        }
        if let value = dictionaryDetails["bonus_amount"] as? CGFloat{
            bonusAmount = value
        }
        if let value = dictionaryDetails["emp_id"] as? Int{
            empId = value
        }
        if let value = dictionaryDetails["end_time_marked"] as? CGFloat{
            endTimeMarkd = value
        }
        if let value = dictionaryDetails["end_time_marked_at"] as? String{
            endTimeMarkedAt = value
        }
        if let value = dictionaryDetails["end_time_marked_by"] as? String{
            endTimeMarkedBy = value
        }
        if let value = dictionaryDetails["image"] as? String{
            profileImageUrl = value
        }
        if let value = dictionaryDetails["is_approved"] as? Int{
            isApproved = value
        }
        if let value = dictionaryDetails["is_attendance_completed"] as? Int{
            isAttendanceCompleted = value
        }
        if let value = dictionaryDetails["is_present"] as? Int{
            isPresent = value
        }
        if let value = dictionaryDetails["is_sick_leave"] as? Int{
            isSickLeave = value
        }
        if let value = dictionaryDetails["is_strike"] as? Int{
            isStrike = value
        }
        if let value = dictionaryDetails["is_suspicious"] as? Int{
            isSuspicious = value
        }
        if let value = dictionaryDetails["marked_at"] as? String{
            markedAt = value
        }
        if let value = dictionaryDetails["name"] as? String{
            name = value
        }
        if let value = dictionaryDetails["site_id"] as? Int{
            siteId = value
        }
        if let value = dictionaryDetails["start_time_marked"] as? CGFloat{
            startTimeMarked = value
        }
        if let value = dictionaryDetails["start_time_marked_at"] as? String{
            startTimeMarkedAt = value
        }
        if let value = dictionaryDetails["start_time_marked_by"] as? String{
            startTimeMarkedBy = value
        }
    }

    
    class func callfetchAtendanceRequset(isAttendanceCompleted: Int, date: String, keyword: String, siteId: String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        
        let serviceName: String!
        serviceName = ObeidiConstants.API.FETCH_ATTENDANCE + "?is_attendance_completed=\(isAttendanceCompleted)&keyword=\(keyword)&site_id=\(siteId)&date=\(date)"
        
        //site_id=32&start_date=2018-01-01&end_date=2019-02-06
        
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as! String
        AFNetworkingServiceManager.sharedmanager.parseLinkUsingGetMethodAndHeader(serviceName, parameter: nil, token: accessToken){
            (success, result, error) in
            if (success! && result != nil){
                print(result as Any)
                let dict = result as! NSDictionary
                if let val = dict["error"] {
                    if case let isError as Bool = val{
                        if isError {
                            completion(false, result, nil)
                        }else{//MARK: SUCCESS CASE
                            completion(true,result,nil)
                        }
                        
                    } else {
                        print("value is nil")
                    }
                } else {
                    
                    print("error key is not present in dict")
                    let dataDict = result as! NSDictionary
                    completion(false, dataDict, error)
                }
            }else if (success! && result == nil){
                let customError: NSError!
                customError = NSError(domain: "Obeidi Errors ", code: 404, userInfo: ["error": "no data to show"])
                completion(false, nil, customError)
                
            }else{
                completion(false, nil, error)
            }
        }
    }
}

class ObeidAttendanceResponseModel:NSObject{
    var error:Int = 0
    var imageBaseUrl:String = ""
    var attendanceResultArray = [ObeidiModelFetchAttendance]()
    init(dictionaryDetails : NSDictionary){
        if let value = dictionaryDetails["error"] as? Int{
            error = value
        }
        if let value = dictionaryDetails["image_base"] as? String{
            imageBaseUrl = value
        }
        if let value = dictionaryDetails["result"] as? NSArray{
            for item in value{
                let atten = ObeidiModelFetchAttendance.init(dictionaryDetails: item as! NSDictionary)
                atten.profileBaseUrl = imageBaseUrl
                attendanceResultArray.append(atten)
            }
        }
    }
}

class ObeidAttendanceRequestModel:NSObject{
    var searchText:String = ""
    var startDate:String = ""
    var siteId:Int = 0
    var isAttendanceCompleteEntry:Bool = false
    func getRequestBody()->String{
        var requestBody:String = ""
        return requestBody
    }
}
