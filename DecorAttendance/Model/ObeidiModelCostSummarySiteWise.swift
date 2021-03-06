//
//  ObeidiModelCostSummarySiteWise.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 12/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

@objcMembers
class ObeidiModelCostSummarySiteWise: NSObject {
    
    var strike_penalty_amount: AnyObject!
    var wage_amount: AnyObject!
    var remaining_bonus_amount: AnyObject!
    var total_amount: AnyObject!
    var over_time_amount: AnyObject!
    var bonus_amount: AnyObject!
    var medical_leave_amount: AnyObject!
    var error: AnyObject!
    var absence_penalty_amount: AnyObject!
    var paid_vaction_amount: AnyObject!
    
    var bonus_budget:AnyObject?
    var net_wage_amount:AnyObject?
    
    var absencePenaltyAmountNew:CGFloat = 0.0
    var bonusAmountNew:CGFloat = 0.0
    var bonusBudgetNew:CGFloat = 0.0
    var equipmentPenaltyAmountNew:CGFloat = 0.0
    var medicalLeaveAmountNew:CGFloat = 0.0
    var netWageAmountNew:CGFloat = 0.0
    var overTimeAmountNew:CGFloat = 0.0
    var paidVacationAmountNew:CGFloat = 0.0
    var remainingBonusAmountNew:CGFloat = 0.0
    var strikePenaltyAmountNew:CGFloat = 0.0
    var totalAmountNew:CGFloat = 0.0
    var wageAmountNew:CGFloat = 0.0
    
    var remainingBonusPercentage:CGFloat = 0.0
    var overTimePercentage:CGFloat = 0.0
    var bonusPercentage:CGFloat = 0.0
    var wagePercentage:CGFloat = 0.0
    var sickLeavePercentage:CGFloat = 0.0
    var paidVacationPercentage:CGFloat = 0.0
    
    
    init(dictionaryDetails : NSDictionary)
    {
        super.init()
        
        if let value = dictionaryDetails["absence_penalty_amount"] as? CGFloat{
            absencePenaltyAmountNew = value
        }
        if let value = dictionaryDetails["bonus_amount"] as? CGFloat{
            bonusAmountNew = value
        }
        if let value = dictionaryDetails["bonus_budget"] as? CGFloat{
            bonusBudgetNew = value
        }
        if let value = dictionaryDetails["equipment_penalty_amount"] as? CGFloat{
            equipmentPenaltyAmountNew = value
        }
        if let value = dictionaryDetails["medical_leave_amount"] as? CGFloat{
            medicalLeaveAmountNew = value
        }
        if let value = dictionaryDetails["net_wage_amount"] as? CGFloat{
            netWageAmountNew = value
        }
        if let value = dictionaryDetails["over_time_amount"] as? CGFloat{
            overTimeAmountNew = value
        }
        if let value = dictionaryDetails["paid_vaction_amount"] as? CGFloat{
            paidVacationAmountNew = value
        }
        if let value = dictionaryDetails["remaining_bonus_amount"] as? CGFloat{
            remainingBonusAmountNew = value
        }
        if let value = dictionaryDetails["strike_penalty_amount"] as? CGFloat{
            strikePenaltyAmountNew = value
        }
        if let value = dictionaryDetails["total_amount"] as? CGFloat{
            totalAmountNew = value
        }
        if let value = dictionaryDetails["wage_amount"] as? CGFloat{
            wageAmountNew = value
        }
        
        remainingBonusPercentage = ((bonusBudgetNew-remainingBonusAmountNew)/bonusBudgetNew)*100.00
        if(remainingBonusPercentage.isNaN){
            remainingBonusPercentage = 0.0
        }
        overTimePercentage = (overTimeAmountNew/totalAmountNew)*100.00
        if(overTimePercentage.isNaN){
            overTimePercentage = 0.0
        }
        bonusPercentage = (bonusAmountNew/totalAmountNew)*100.00
        if(bonusPercentage.isNaN){
            bonusPercentage = 0.0
        }
        wagePercentage = (netWageAmountNew/totalAmountNew)*100.00
        if(wagePercentage.isNaN){
            wagePercentage = 0
        }
        sickLeavePercentage = (medicalLeaveAmountNew/totalAmountNew)*100.00
        if(sickLeavePercentage.isNaN){
            sickLeavePercentage = 0.0
        }
        paidVacationPercentage = (paidVacationAmountNew/totalAmountNew)*100.00
        if(paidVacationPercentage.isNaN){
            paidVacationPercentage = 0.0
        }
        
        for (key, value) in dictionaryDetails {
            let keyName = key as! String
            let keyValue = value as AnyObject
            
            if self.responds(to: Selector("\(keyName)")) == true {
                self.setValue(keyValue, forKey: keyName)
            } else {
                //print("=====> \(keyName) == \(keyValue)")
                print("var \(keyName): AnyObject!")
            }
            
        }
    }
    
    class func getCostSummaryDetailsObjectDict(costSummaryDataDict: NSDictionary) -> ObeidiModelCostSummarySiteWise? {
        if costSummaryDataDict.count != 0 {
            
            let list = ObeidiModelCostSummarySiteWise(dictionaryDetails: costSummaryDataDict)
            return list
        }
        return nil
    }
    
    class func callCostSummaryRequset(requestBody: String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        let serviceName = ObeidiConstants.API.COST_SUMMARY_SITEWISE+requestBody
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
                            let valDict = dataDict["result"] as! NSDictionary
                            completion(true, getCostSummaryDetailsObjectDict(costSummaryDataDict: valDict), nil)
                            
                        }
                        
                    } else {
                        print("value is nil")
                    }
                } else {
                    
                    print("error key is not present in dict")
                    let dataDict = result as! NSDictionary
                    //completion(true, getCostSummaryDetailsObjectDict(costSummaryDataDict: dataDict), nil)
                    completion(false, nil, error)
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
