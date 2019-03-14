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
    
    class func callCostSummaryRequset(keyword: String, startDate: String, endDate: String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        
        let serviceName: String!
        if (keyword != "" && startDate != "" && endDate != ""){
            
            serviceName = ObeidiConstants.API.COST_SUMMARY_LABOURWISE + "?start_date=\(startDate)&end_date=\(endDate)&keyword=\(keyword)"
        }else{
            serviceName = ObeidiConstants.API.COST_SUMMARY_LABOURWISE
            
        }
        
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
