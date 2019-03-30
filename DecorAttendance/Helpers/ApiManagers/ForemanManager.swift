//
//  ForemanManager.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 3/29/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ForemanManager: CLBaseService {
    func getAttendanceSummary(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAttendanceSummary(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getAttendanceSummaryResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForAttendanceSummary(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.ATTENDANCE_SUMMARY+body, requestMethod_: "GET")
        //requestModel.requestBody = body
        return requestModel
    }
    
    func getAttendanceSummaryResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = AttendanceSummaryResponseModel.init(dict:dict)
        return responseModel
    }
}

class AttendanceSummaryResponseModel : NSObject{
    var error:Int = 0
    var presentCount:Int = 0
    var absentCount:Int = 0
    var total:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["error"] as? Int{
            error = value
        }
        if let value = dict["present_count"] as? Int{
            presentCount = value
        }
        if let value = dict["absent_count"] as? Int{
            absentCount = value
        }
        if let value = dict["total"] as? Int{
            total = value
        }
    }
}

class ForemanAttendanceRequestModel:NSObject{
    var attendanceDate:String = ""
    func getReqestBody()->String{
        var requestBody = ""
        if (attendanceDate.count != 0 ){
            requestBody = "date=\(attendanceDate)"
        }
        print("Request Body")
        print("-------------------------")
        print(requestBody)
        return requestBody
    }
}
