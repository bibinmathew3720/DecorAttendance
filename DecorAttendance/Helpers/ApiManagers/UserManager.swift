//
//  UserManager.swift
//  DecorAttendance
//
//  Created by Nimmy K Das on 3/9/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class UserManager: CLBaseService {
    
    func getProfileApi(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForProfile(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getProfileResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForProfile(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.PROFILE, requestMethod_: "GET")
        requestModel.requestBody = body
        return requestModel
    }
    
    func getProfileResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = CCLUBProfileSettingsResponseModel.init(dict:dict)
        return responseModel
    }
    
    
    
    
}

class CCLUBProfileSettingsResponseModel : NSObject{
    
    var statusMessage:String = ""
    var statusCode:Int = 0
    var member_id:Int = 0
    var email_address:String = ""
    var temp_password:String = ""
    var password:String = ""
    var first_name:String = ""
    var last_name:String = ""
    var usertype_id:Int = 0
    var gender:String = ""
    var profile_pic:String = ""
    var notification_settings:Int = 0
    var phone_number:String = ""
    var language_id:Int = 0
    var device_token:String = ""
    var created_date:String = ""
    var platform:Int = 0
    var membership_status:Int = 0
    
    
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        
        if let user = dict["settings"] as? AnyObject{
            if let value = user["usertype_id"] as? Int{
                usertype_id = value
            }
            if let value = user["platform"] as? Int{
                platform = value
            }
            if let value = user["membership_status"] as? Int{
                membership_status = value
            }
            if let value = user["member_id"] as? Int{
                member_id = value
            }
            if let value = user["language_id"] as? Int{
                language_id = value
            }
            if let value = user["phone_number"] as? String{
                phone_number = value
            }
            if let value = user["notification_settings"] as? Int{
                notification_settings = value
            }
            if let value = user["platform"] as? Int{
                platform = value
            }
            if let value = user["first_name"] as? String{
                first_name = value
            }
            if let value = user["password"] as? String{
                password = value
            }
            if let value = user["temp_password"] as? String{
                temp_password = value
            }
            if let value = user["email_address"] as? String{
                email_address = value
            }
            if let value = user["last_name"] as? String{
                last_name = value
            }
            if let value = user["device_token"] as? String{
                device_token = value
            }
            if let value = user["created_date"] as? String{
                created_date = value
            }
            if let value = user["gender"] as? String{
                gender = value
            }
            if let value = user["profile_pic"] as? String{
                profile_pic = value
            }
        }
    }
}

