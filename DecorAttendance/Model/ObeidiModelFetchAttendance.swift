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
    var isEndTimeMarkd:Bool = false
    var endTimeMarkedAt:String = ""
    var endTimeMarkedBy:String = ""
    var endTimeImage:String = ""
    var endTimeLatitude:Double = 0.0
    var endTimeLongitude:Double = 0.0
    var profileImageUrl:String = ""
    var profileBaseUrl:String = ""
    var isApproved:Int = -1
    var isAttendanceCompleted:Bool = false
    var isPresent:Bool = false
    var isSickLeave:Bool = false
    var isStrike:Bool = false
    var isSuspicious:Bool = false
    var markedAt:String = ""
    var name:String = ""
    var siteId:Int = 0
    var isStartTimeMarked:Bool = false
    var startTimeMarkedAt:String = ""
    var startTimeMarkedBy:String = ""
    var startTimeImage:String = ""
    var startTimeLatitude:Double = 0.0
    var startTimeLongitude:Double = 0.0
    var imageBaseUrl:String = ""
    
    init(dictionaryDetails : NSDictionary)
    {
        super.init()
        if let value = dictionaryDetails["profile_image"] as? String{
            profileImageUrl = value
        }
        if let value = dictionaryDetails["image_base"] as? String{
            imageBaseUrl = value
        }
        if let value = dictionaryDetails["attendance_id"] as? Int{
            attendanceId = value
        }
        if let value = dictionaryDetails["bonus_amount"] as? CGFloat{
            bonusAmount = value
        }
        if let value = dictionaryDetails["emp_id"] as? Int{
            empId = value
        }
        if let value = dictionaryDetails["end_time_marked"] as? Int{
            if value == 1{
                isEndTimeMarkd = true
            }
            else{
                isEndTimeMarkd = false
            }
        }
        if let value = dictionaryDetails["end_time_marked_at"] as? String{
            endTimeMarkedAt = value
        }
        if let value = dictionaryDetails["end_time_marked_by"] as? String{
            endTimeMarkedBy = value
        }
        if let value = dictionaryDetails["end_time_image"] as? String{
            endTimeImage = value
        }
        if let value = dictionaryDetails["lat_end_time"] as? Double{
            endTimeLatitude = value
        }
        if let value = dictionaryDetails["lng_end_time"] as? Double{
            endTimeLongitude = value
        }
        if let value = dictionaryDetails["image"] as? String{
            profileImageUrl = value
        }
        if let value = dictionaryDetails["is_approved"] as? Int{
               isApproved = value
        }
        if let value = dictionaryDetails["is_attendance_completed"] as? Int{
            if value == 1{
                isAttendanceCompleted = true
            }
            else{
                isAttendanceCompleted = false
            }
        }
        if let value = dictionaryDetails["is_present"] as? Int{
            if value == 1{
                isPresent = true
            }
            else{
               isPresent = false
            }
        }
        if let value = dictionaryDetails["is_sick_leave"] as? Int{
            if value == 1 {
                isSickLeave = true
            }
            else{
               isSickLeave = false
            }
        }
        if let value = dictionaryDetails["is_strike"] as? Int{
            if value == 1 {
                isStrike = true
            }
            else{
                isStrike = false
            }
        }
        if let value = dictionaryDetails["is_suspicious"] as? Int{
            if value == 1 {
                isSuspicious = true
            }
            else{
                isSuspicious = false
            }
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
        if let value = dictionaryDetails["start_time_marked"] as? Int{
            if value == 1{
                isStartTimeMarked = true
            }
            else{
                isStartTimeMarked = false
            }
        }
        if let value = dictionaryDetails["start_time_marked_at"] as? String{
            startTimeMarkedAt = value
        }
        if let value = dictionaryDetails["start_time_marked_by"] as? String{
            startTimeMarkedBy = value
        }
        if let value = dictionaryDetails["start_time_image"] as? String{
            startTimeImage = value
        }
        if let value = dictionaryDetails["lat_start_time"] as? Double{
            startTimeLatitude = value
        }
        if let value = dictionaryDetails["lng_start_time"] as? Double{
            startTimeLongitude = value
        }
    }

    
    class func callfetchAtendanceRequset(requestBody: String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        let serviceName: String!
        serviceName = ObeidiConstants.API.FETCH_ATTENDANCE + requestBody
        
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
    
    class func callGetAttendanceDetailApi(requestBody: String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        let serviceName: String!
        serviceName = ObeidiConstants.API.GET_ATTENDANCE_DETAIL + requestBody
        
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
    var isSuspicious:Bool = false
    func getRequestBody()->String{
        var requestBody = ""
        if (isSuspicious){
           requestBody = "is_suspicious=1"
        }
        else{
            if (isAttendanceCompleteEntry){
                requestBody = "is_attendance_completed=1"
            }
            else{
                requestBody = "is_attendance_completed=0"
            }
        }
        if (startDate.count != 0 ){
            requestBody = requestBody + "&date=\(startDate)"
        }
        if (siteId != 0){
            requestBody = requestBody + "&site_id=\(siteId)"
        }
        requestBody = requestBody + "&keyword=\(searchText)"
        
        print("Request Body")
        print("-------------------------")
        print(requestBody)
        return requestBody
    }
}
