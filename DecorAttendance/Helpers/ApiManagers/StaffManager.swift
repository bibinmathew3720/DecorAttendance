//
//  StaffManager.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/20/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class StaffManager: CLBaseService {
    func getLeavesListApi(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
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
