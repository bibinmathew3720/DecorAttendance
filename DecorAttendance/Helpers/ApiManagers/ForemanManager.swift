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
    var presentCount:CGFloat = 0
    var absentCount:CGFloat = 0
    var pendingCount:CGFloat = 0
    var total:CGFloat = 0
    var absentPercentage:CGFloat = 0.0
    var presentPercentage:CGFloat = 0.0
    var pendingPercentage:CGFloat = 0.0
    init(dict:[String:Any?]) {
        if let value = dict["error"] as? Int{
            error = value
        }
        if let value = dict["present_count"] as? Int{
            presentCount =  CGFloat(Float(value))
        }
        if let value = dict["absent_count"] as? Int{
            absentCount = CGFloat(Float(value))
        }
        if let value = dict["not_marked"] as? Int{
            pendingCount = CGFloat(Float(value))
        }
        if let value = dict["total"] as? Int{
            total =  CGFloat(Float(value))
        }
        absentPercentage = (absentCount/total)*100.0
        if(absentPercentage.isNaN){
            absentPercentage = 0.0
        }
        presentPercentage = (presentCount/total)*100.0
        if(presentPercentage.isNaN){
            presentPercentage = 0.0
        }
        pendingPercentage = (pendingCount/total)*100.0
        if(pendingPercentage.isNaN){
            pendingPercentage = 0.0
        }
    }
}

class ForemanAttendanceRequestModel:NSObject{
    var attendanceDate:String = ""
    var siteId:Int = 0
    func getReqestBody()->String{
        var requestBody = ""
        if (attendanceDate.count != 0 ){
            requestBody = "date=\(attendanceDate)"
        }
        if (requestBody.count>0){
            requestBody = requestBody + "&site_id=\(siteId)"
        }
        else{
            requestBody = requestBody + "site_id=\(siteId)"
        }
        print("Request Body")
        print("-------------------------")
        print(requestBody)
        return requestBody
    }
}
