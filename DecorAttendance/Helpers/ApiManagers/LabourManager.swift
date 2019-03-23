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
    var error:Int = 0
    var paidVacationAmount:CGFloat = 0.0
    var medicalLeaveAmount:CGFloat = 0.0
    var absencePenaltyAmount:CGFloat = 0.0
    var overTimeAmount:CGFloat = 0.0
    var strikePenaltyAmount:CGFloat = 0.0
    var netSalary:CGFloat = 0.0
    var totalIncentive:CGFloat = 0.0
    var bonusAmount:CGFloat = 0.0
    var workTimeMinute:Int = 0
    var totalAbsentDayCount:Int = 0
    var totalPresentDayCount:Int = 0
    var totalMedicalLeaveDayCount:Int = 0
    var equipmentPenaltyAmount:CGFloat = 0.0
    var totalStrikeDayCount:Int = 0
    var loanAmount:CGFloat = 0.0
    var wageAmount:CGFloat = 0.0
    var overTimeMinutes:Int = 0
    var totalAmount:CGFloat = 0.0
    var totalPenalty:CGFloat = 0.0
    var totalBonusWorkTime:Int = 0
    
    var wagePercentage:CGFloat = 0.0
    var overTimePercentage:CGFloat = 0.0
    var bonusPercentage:CGFloat = 0.0
    var medicalLeavePercentage:CGFloat = 0.0
    var paidVacationPercentage:CGFloat = 0.0
    var equipmentPenaltyPercentage:CGFloat = 0.0
    var totalStrikePercentage:CGFloat = 0.0
    var totalAbsencePerncetage:CGFloat = 0.0
    
    init(dict:[String:Any?]) {
        if let value = dict["error"] as? Int{
            error = value
        }
        if let value = dict["paid_vaction_amount"] as? CGFloat{
            paidVacationAmount = value
        }
        if let value = dict["medical_leave_amount"] as? CGFloat{
            medicalLeaveAmount = value
        }
        if let value = dict["absence_penalty_amount"] as? CGFloat{
            absencePenaltyAmount = value
        }
        if let value = dict["over_time_amount"] as? CGFloat{
            overTimeAmount = value
        }
        if let value = dict["strike_penalty_amount"] as? CGFloat{
            strikePenaltyAmount = value
        }
        if let value = dict["net_salary"] as? CGFloat{
            netSalary = value
        }
        if let value = dict["net_salary"] as? String{
            if let n = NumberFormatter().number(from: value) {
                netSalary = CGFloat(truncating: n)
            }
        }
        if let value = dict["total_incentive"] as? CGFloat{
            totalIncentive = value
        }
        if let value = dict["bonus_amount"] as? CGFloat{
            bonusAmount = value
        }
        if let value = dict["work_time_minutes"] as? Int{
            workTimeMinute = value
        }
        if let value = dict["total_absent_day_count"] as? Int{
            totalAbsentDayCount = value
        }
        if let value = dict["total_present_day_count"] as? Int{
            totalPresentDayCount = value
        }
        if let value = dict["total_medical_leave_day_count"] as? Int{
            totalMedicalLeaveDayCount = value
        }
        if let value = dict["equipment_penalty_amount"] as? CGFloat{
            equipmentPenaltyAmount = value
        }
        if let value = dict["total_strike_day_count"] as? Int{
            totalStrikeDayCount = value
        }
        if let value = dict["loan_amount"] as? CGFloat{
            loanAmount = value
        }
        if let value = dict["wage_amount"] as? CGFloat{
            wageAmount = value
        }
        if let value = dict["over_time_minutes"] as? Int{
            overTimeMinutes = value
        }
        if let value = dict["total_amount"] as? CGFloat{
            totalAmount = value
        }
        if let value = dict["total_penalty"] as? CGFloat{
            totalPenalty = value
        }
        if let value = dict["total_bonus_work_time"] as? Int{
            totalBonusWorkTime = value
        }
        
        wagePercentage = (wageAmount/totalAmount)*100.00
        if(wagePercentage.isNaN){
            wagePercentage = 0
        }
        
        overTimePercentage = (overTimeAmount/totalAmount)*100.00
        if(overTimePercentage.isNaN){
            overTimePercentage = 0.0
        }
        
        bonusPercentage = (bonusAmount/totalAmount)*100.00
        if(bonusPercentage.isNaN){
            bonusPercentage = 0.0
        }
        
        medicalLeavePercentage = (medicalLeaveAmount/totalAmount)*100.00
        if(medicalLeavePercentage.isNaN){
            medicalLeavePercentage = 0.0
        }
        
        paidVacationPercentage = (paidVacationAmount/totalAmount)*100.00
        if(paidVacationPercentage.isNaN){
            paidVacationPercentage = 0.0
        }
        
        
        //Penalty
        
        equipmentPenaltyPercentage = (equipmentPenaltyAmount/totalPenalty)*100
        if(equipmentPenaltyPercentage.isNaN){
            equipmentPenaltyPercentage = 0.0
        }
        
        totalStrikePercentage = (strikePenaltyAmount/totalPenalty)*100
        if(totalStrikePercentage.isNaN){
            totalStrikePercentage = 0.0
        }
        
        totalAbsencePerncetage = (absencePenaltyAmount/totalPenalty)*100
        if(totalAbsencePerncetage.isNaN){
            totalAbsencePerncetage = 0.0
        }
    }
}

class SiteWiseRequestModel:NSObject{
    var startDate:String = ""
    var endDate:String = ""
    var siteId:Int = 0
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

class LabourSummaryDetailsRequestModel:NSObject{
    var startDate:String = ""
    var endDate:String = ""
    var siteId:Int = 0
    var empId:Int = 0
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

class SafetyEquipmentsResponseModel:NSObject{
    var error:Int = 0
    var imageBaseurl:String = ""
    var SafetyEquipments = [SafetyEquipment]()
    init(dict:[String:Any?]) {
        if let value = dict["error"] as? Int{
            error = value
        }
        if let value = dict["image_base"] as? String{
            imageBaseurl = value
        }
        if let value = dict["result"] as? NSArray{
            for item in value{
                if let it = item as? [String:AnyObject] {
                    let equipment = SafetyEquipment.init(dict: it)
                    equipment.imageBaseUrl = imageBaseurl
                    SafetyEquipments.append(equipment)
                }
            }
        }
    }
}

class SafetyEquipment:NSObject{
    var imageBaseUrl:String = ""
    var id:Int = 0
    var imageName:String = ""
    var internalName:String = ""
    var name:String = ""
    var penalty:CGFloat = 0.0
    init(dict:[String:Any?]) {
        if let value = dict["id"] as? Int{
            id = value
        }
        if let value = dict["image"] as? String{
            imageName = value
        }
        if let value = dict["intenal_name"] as? String{
            internalName = value
        }
        if let value = dict["name"] as? String{
            name = value
        }
        if let value = dict["penalty"] as? CGFloat{
            penalty = value
        }
    }
}

