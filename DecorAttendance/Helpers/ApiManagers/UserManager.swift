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
        let responseModel = DecoreProfileResponseModel.init(dict:dict)
        return responseModel
    }
    
    
    
    
}

class DecoreProfileResponseModel : NSObject{
    
    var dob:String = ""
    var id:Int = 0
    var emp_id:Int = 0
    var name:String = ""
    var phone:String = ""
    var image:String = ""
    var email:String = ""
    var date_of_joining:String = ""
    var error:String = ""
    var sites = [DecoreSitesModel ]()
    
    init(dict:[String:Any?]) {
        if let user = dict["team"] as? AnyObject{
            if let value = user["name"] as? String{
                name = value
            }
            
            if let value = user["id"] as? Int{
                id = value
            }
        }
        if let value = dict["dob"] as? String{
            dob = value
        }
        if let value = dict["error"] as? String{
            error = value
        }
        if let value = dict["date_of_joining"] as? String{
            date_of_joining = value
        }
        if let value = dict["phone"] as? String{
            phone = value
        }
        if let value = dict["email"] as? String{
            email = value
        }
        if let value = dict["name"] as? String{
            name = value
        }
        if let value = dict["image"] as? String{
            image = value
        }
        if let value = dict["emp_id"] as? Int{
            emp_id = value
        }
        if let _dict = dict["sites"] as? [[String:Any?]]{
            for site in _dict{
                sites.append(DecoreSitesModel.init(dict: site))
            }
        }
  
    }
}

class DecoreSitesModel : NSObject{
    
    var lng:Double = 0.0
    var lat:Double = 0.0
    var bonus_budget:Int = 0
    var labour_cost_budget:Int = 0
    var location_name:String = ""
    var site_id:Int = 0
    var site_name:String = ""
    
    init(dict:[String:Any?]) {
        if let value = dict["lng"] as? Double{
            lng = value
        }
        if let value = dict["lat"] as? Double{
            lat = value
        }
        if let value = dict["bonus_budget"] as? Int{
            bonus_budget = value
        }
        if let value = dict["labour_cost_budget"] as? Int{
            labour_cost_budget = value
        }
        if let value = dict["location_name"] as? String{
            location_name = value
        }
        if let value = dict["site_id"] as? Int{
            site_id = value
        }
        if let value = dict["site_name"] as? String{
            site_name = value
        }
    }
}
