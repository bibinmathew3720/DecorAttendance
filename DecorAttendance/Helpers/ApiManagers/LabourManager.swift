//
//  LabourManager.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 3/14/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class LabourManager: CLBaseService {
    
    func getCostSummaryDetail(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForLabourManager(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCostSummaryDetailResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForLabourManager(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.COST_SUMMARY_LABOURWISE_DETAIL+body, requestMethod_: "GET")
        //requestModel.requestBody = body
        return requestModel
    }
    
    func getCostSummaryDetailResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = CostSummaryDetailResponseModel.init(dict:dict)
        return responseModel
    }
}

class CostSummaryDetailResponseModel : NSObject{
    
    init(dict:[String:Any?]) {
    }
}

