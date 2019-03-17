//
//  ObeidiModelCostSummaryLabourWise.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 15/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

@objcMembers
class ObeidiModelCostSummaryLabourWise: NSObject {
    var error:Int = 0
    var imageBaseUrlString = ""
    var costSummaryArray = [CostSummary]()
    init(dictionaryDetails : NSDictionary)
    {
        super.init()
        if let value = dictionaryDetails["error"] as? Int{
            error = value
        }
        if let value = dictionaryDetails["image_base"] as? String{
            imageBaseUrlString = value
        }
        if let resultArray = dictionaryDetails["result"] as? NSArray{
            for item in resultArray{
                if let it = item as? NSDictionary{
                    let costSummary = CostSummary.init(dictionaryDetails: it)
                    costSummary.imageBaseUrl = imageBaseUrlString
                    costSummaryArray.append(costSummary)
                }
            }
        }
    }
    
    class func getCostSummaryDetailsObjectDict(costSummaryDataDict: NSDictionary) -> ObeidiModelCostSummaryLabourWise? {
        if costSummaryDataDict.count != 0 {
            
            let list = ObeidiModelCostSummaryLabourWise(dictionaryDetails: costSummaryDataDict)
            return list
        }
        return nil
    }
    
    class func callCostSummaryRequset(requestBody:String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        let serviceName = ObeidiConstants.API.COST_SUMMARY_LABOURWISE+requestBody
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
                            let dataDict = result as! NSDictionary
                            completion(true, getCostSummaryDetailsObjectDict(costSummaryDataDict: dataDict), nil)
                            
                        }
                        
                    } else {
                        print("value is nil")
                    }
                } else {
                    
                    print("error key is not present in dict")
                    let dataDict = result as! NSDictionary
                    completion(true, getCostSummaryDetailsObjectDict(costSummaryDataDict: dataDict), nil)
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

class CostSummary: NSObject {
    var empId:Int = 0
    var imageBaseUrl:String = ""
    var profileImageUrl:String = ""
    var name:String = ""
    var netSalary:CGFloat = 0.0
    var netWageAmount:CGFloat = 0.0
    var totalIncentive:CGFloat = 0.0
    var totalPenalty:CGFloat = 0.0
    init(dictionaryDetails : NSDictionary)
    {
        if let value = dictionaryDetails["emp_id"] as? Int{
            empId = value
        }
        if let value = dictionaryDetails["image"] as? String{
            profileImageUrl = value
        }
        if let value = dictionaryDetails["name"] as? String{
            name = value
        }
        if let value = dictionaryDetails["net_salary"] as? CGFloat{
            netSalary = value
        }
        if let value = dictionaryDetails["net_wage_amount"] as? CGFloat{
            netWageAmount = value
        }
        if let value = dictionaryDetails["total_incentive"] as? CGFloat{
            totalIncentive = value
        }
        if let value = dictionaryDetails["total_penalty"] as? CGFloat{
            totalPenalty = value
        }
    }
}

class LabourWiseRequestModel:NSObject{
    var startDate:String = ""
    var endDate:String = ""
    var searchText:String = ""
    var siteId:Int = 0
    var pageIndex:Int = 0
    var perPage:Int = 0
    func getReqestBody()->String{
        var requestBody = ""
        if (startDate.count != 0 ){
            requestBody = "start_date=\(startDate)"
        }
        if (endDate.count != 0){
            if (requestBody.count>0){
                requestBody = requestBody + "&end_date=\(endDate)"
            }
            else{
                requestBody = requestBody + "end_date=\(endDate)"
            }
        }
        if (searchText.count != 0){
            if (requestBody.count>0){
                requestBody = requestBody + "&keyword=\(searchText)"
            }
            else{
                requestBody = requestBody + "keyword=\(searchText)"
            }
        }
        if (requestBody.count>0){
            requestBody = requestBody + "&page=\(pageIndex)"
        }
        else{
            requestBody = requestBody + "page=\(pageIndex)"
        }
        if (requestBody.count>0){
            requestBody = requestBody + "&per_page=\(perPage)"
        }
        else{
            requestBody = requestBody + "per_page=\(perPage)"
        }
//        if (requestBody.count>0){
//            requestBody = requestBody + "&site_id=\(siteId)"
//        }
//        else{
//            requestBody = requestBody + "site_id=\(siteId)"
//        }
        print("Request Body")
        print("-------------------------")
        print(requestBody)
        return requestBody
    }
}
