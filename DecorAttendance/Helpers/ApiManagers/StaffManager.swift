//
//  StaffManager.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/20/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class StaffManager: CLBaseService {
    func  getLeavesListApi(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForLeavesList(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getLeaveListResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForLeavesList(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.STAFF_ATTENDANCE_LIST_URL+body, requestMethod_: "GET")
        return requestModel
    }
    
    func getLeaveListResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = LeavesListResponseModel.init(dict:dict)
        return responseModel
    }
    
    //Calling Medical Attendance Api
    
    func  getMedicalLeavesListApi(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForMedicalLeavesList(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getMedicalLeaveListResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForMedicalLeavesList(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.STAFF_MEDICAL_ATTENDANCE_LIST_URL+body, requestMethod_: "GET")
        return requestModel
    }
    func getMedicalLeaveListResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = MedicalLeavesResponseModel.init(dict:dict)
        return responseModel
    }
    
}

class LeavesListResponseModel : NSObject{
    var error:Int = 0
    var message:String = ""
    var leaveMonths = [LeaveMonth]()
    init(dict:[String:Any?]) {
        
        if let value = dict["error"] as? Int{
            error = value
        }
        if let value = dict["message"] as? String{
            message = value
        }
        if let value = dict["result"] as? NSArray{
            for item in value{
                if let _item = item as? [String:AnyObject]{
                    leaveMonths.append(LeaveMonth.init(dict: _item))
                }
            }
        }
    }
}

class MedicalLeavesResponseModel : NSObject{
    var error:Int = 0
    var message:String = ""
    var medicalLeaves = [MedicalLeave]()
    init(dict:[String:Any?]) {
        
        if let value = dict["error"] as? Int{
            error = value
        }
        if let value = dict["message"] as? String{
            message = value
        }
        if let value = dict["result"] as? NSArray{
            for item in value{
                if let _item = item as? [String:AnyObject]{
                    medicalLeaves.append(MedicalLeave.init(dict: _item))
                }
            }
        }
    }
}


class LeaveMonth : NSObject {
    var monthName:String = ""
    var monthCount:Int = 0
    var leaveCount:Int = 0
    
    init(dict:[String:Any?]) {
        if let value = dict["label"] as? String{
            monthName = value
        }
        if let value = dict["month"] as? Int{
            monthCount = value
        }
        if let value = dict["leave_count"] as? Int{
            leaveCount = value
        }
    }
}

class MedicalLeave : NSObject {
    var approvedBy:String = ""
    var startDate:String = ""
    var endDate:String = ""
    var isApproved:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["approved_by"] as? String{
            approvedBy = value
        }
        if let value = dict["start_date"] as? String{
            startDate = value
        }
        if let value = dict["end_date"] as? String{
            endDate = value
        }
        if let value = dict["is_approved"] as? Int{
            isApproved = value
        }
    }
}

class LeavesListRequest:NSObject {
    var startMonth:Int = 0
    var endMonth:Int = 0
    var startYear:Int = 0
    var endYear:Int = 0
    func getRequestBody()->String{
        var requestString = ""
        requestString = "start_month=\(startMonth)"
        requestString = requestString + "&end_month=\(endMonth)"
        requestString = requestString + "&start_year=\(startYear)"
        requestString = requestString + "&end_year=\(endYear)"
        print(requestString)
        return requestString
    }
}
