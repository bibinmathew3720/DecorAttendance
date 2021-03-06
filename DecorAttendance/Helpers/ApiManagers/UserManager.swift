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
    
    func getAboutApi(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAbout(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getAboutResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForAbout(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.ABOUT, requestMethod_: "GET")
        requestModel.requestBody = body
        return requestModel
    }
    
    func getAboutResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = DecoreAboutResponseModel.init(dict:dict)
        return responseModel
    }
    
    func getEmployeesApi(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForEmployees(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getEmployeesResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForEmployees(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.EMPLOYEES+body, requestMethod_: "GET")
        return requestModel
    }
    
    func getEmployeesResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = DecoreEmployeeResponseModel.init(dict:dict)
        return responseModel
    }
    
    func callChangePasswordApi(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForChangePassword(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getChangePasswordResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForChangePassword(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.CHANGE_PASSWORD, requestMethod_: "POST")
        requestModel.requestBody = body
        return requestModel
    }
    
    func getChangePasswordResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = ChangePasswordModel.init(dict:dict)
        return responseModel
    }
    
    func callForgotPasswordApi(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForForgotPassword(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getForgotPasswordResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForForgotPassword(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.RESET_PASSWORD, requestMethod_: "POST")
        requestModel.requestBody = body
        return requestModel
    }
    
    func getForgotPasswordResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = ForgotPasswordResponseModel.init(dict:dict)
        return responseModel
    }
    //Get Employee Details Api
    
    func getEmployeeDetailsApi(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelGetEmployeeDetails(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getEmployeeDetailsResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelGetEmployeeDetails(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.EMPLOYEEDETAIL + "/" + body, requestMethod_: "GET")
        return requestModel
    }
    
    func getEmployeeDetailsResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = GetEmployeeDetailsResponseModel.init(dict:dict)
        return responseModel
    }
    
    //OTP verify api
    
    func callVerifyOTPApi(with body:String, success : @escaping (Any,_ response:HTTPURLResponse)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForVerifyOTP(with:body), success: {
            (resultData,response)  in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getVerifyOTPResponseModel(dict: jdict) as Any, response)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForVerifyOTP(with body:String)->CLNetworkModel{
        let requestModel = CLNetworkModel.init(url:ObeidiConstants.API.MAIN_DOMAIN + ObeidiConstants.API.VERIFY_OTP, requestMethod_: "POST")
        requestModel.requestBody = body
        return requestModel
    }
    
    func getVerifyOTPResponseModel(dict:[String : Any?]) -> Any? {
        let responseModel = LoginResponseModel.init(dict:dict)
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

class DecoreAboutResponseModel : NSObject{
    
    var about_content:String = ""
    var phone_number:String = ""
    var website:String = ""
    var banner_image:String = ""
    var mission_and_vision:String = ""
    var message_from_ceo:String = ""
    var email:String = ""
    var image_base:String = ""
    var ceo_image:String = ""
    var error:String = ""
    
    
    init(dict:[String:Any?]) {
   
        if let value = dict["about_content"] as? String{
            about_content = value
        }
        if let value = dict["phone_number"] as? String{
            phone_number = value
        }
        if let value = dict["website"] as? String{
            website = value
        }
        if let value = dict["banner_image"] as? String{
            banner_image = value
        }
        if let value = dict["mission_and_vision"] as? String{
            mission_and_vision = value
        }
        if let value = dict["message_from_ceo"] as? String{
            message_from_ceo = value
        }
        if let value = dict["email"] as? String{
            email = value
        }
        if let value = dict["image_base"] as? String{
            image_base = value
        }
        if let value = dict["ceo_image"] as? String{
            ceo_image = value
        }
        if let value = dict["error"] as? String{
            error = value
        }
    }
}

class DecoreEmployeeResponseModel : NSObject{
    
    var image_base:String = ""
    var error:Int = 0
    var employees = [DecoreEmployeeModel ]()
    
    init(dict:[String:Any?]) {
        if let value = dict["image_base"] as? String{
            image_base = value
        }
        if let value = dict["error"] as? Int{
            error = value
        }
        if let _dict = dict["result"] as? [[String:Any?]]{
            for emp in _dict{
                employees.append(DecoreEmployeeModel.init(dict: emp))
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

class ChangePasswordModel : NSObject{
    var error:Int = 0
    var message:String = ""
    
    init(dict:[String:Any?]) {
        if let value = dict["error"] as? Int{
            error = value
        }
        if let value = dict["message"] as? String{
            message = value
        }
    }
}

class ForgotPasswordResponseModel : NSObject{
    var error:Int = 0
    var message:String = ""
    var resetSecret:String = ""
    var clientId:Int = 0
    
    init(dict:[String:Any?]) {
        
        if let value = dict["error"] as? Int{
            error = value
        }
        if let value = dict["message"] as? String{
            message = value
        }
        if let value = dict["reset_secret"] as? String{
            resetSecret = value
        }
        if let value = dict["client_id"] as? Int{
            clientId = value
        }
    }
}

class VerifyOTPRequestModel:NSObject{
    var resetSecret:String = ""
    var clientId:String = ""
    var email:String = ""
    var password:String = ""
    func getRequestBody()->String{
        var dict:[String:AnyObject] = [String:AnyObject]()
        dict.updateValue(resetSecret as AnyObject, forKey: "reset_secret")
        dict.updateValue(clientId as AnyObject, forKey: "client_id")
        dict.updateValue(email as AnyObject, forKey: "email")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
}


class DecoreEmployeeModel : NSObject{
    var employee_type:String = ""
    var image:String = ""
    var name:String = ""
    var rating:String = ""
    var wage_hourly:Int = 0
    var total_rating:Int = 0
    var site_id:Int = 0
    var date_of_joining:String = ""
    var emp_id:Int = 0
    var dob:String = ""
    
    init(dict:[String:Any?]) {
        
        if let value = dict["emp_id"] as? Int{
            emp_id = value
        }
        if let value = dict["site_id"] as? Int{
            site_id = value
        }
        if let value = dict["dob"] as? String{
            dob = value
        }
        if let value = dict["total_rating"] as? Int{
            total_rating = value
        }
        if let value = dict["wage_hourly"] as? Int{
            wage_hourly = value
        }
        if let value = dict["date_of_joining"] as? String{
            date_of_joining = value
        }
        if let value = dict["employee_type"] as? String{
            employee_type = value
        }
        if let value = dict["image"] as? String{
            image = value
        }
        if let value = dict["name"] as? String{
            name = value
        }
        if let value = dict["rating"] as? String{
            rating = value
        }
    }
}
class DecoreEmployeeDetailModel : NSObject{
    var name:String = ""
    var rating:Int = 0
    var rating_type:String = ""
    var total_rating:Int = 0
    
    
    init(dict:[String:Any?]) {
        
        if let value = dict["rating"] as? Int{
            rating = value
        }
        if let value = dict["name"] as? String{
            name = value
        }
        if let value = dict["rating_type"] as? String{
            rating_type = value
        }
        if let value = dict["total_rating"] as? Int{
            total_rating = value
        }
        
    }
}

class GetEmployeeDetailsResponseModel : NSObject{
    var employee = [DecoreEmployeeDetailModel ]()
    init(dict:[String:Any?]) {
        if let _dict = dict["result"] as? [[String:Any?]]{
            for emp in _dict{
                employee.append(DecoreEmployeeDetailModel.init(dict: emp))
            }
        }
    }
}

class ChangePwdRequestModel:NSObject {
    var current:String = ""
    var new:String = ""
    var confirm:String = ""

    
    func getRequestBody()->String{
        var dict:[String:AnyObject] = [String:AnyObject]()
        dict.updateValue(new as AnyObject, forKey: "new_password")
        dict.updateValue(current as AnyObject, forKey: "old_password")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
}

class ForgotPwdRequestModel:NSObject {
    var email:String = ""
    func getRequestBody()->String{
        var dict:[String:AnyObject] = [String:AnyObject]()
        dict.updateValue(email as AnyObject, forKey: "email")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
}

class  EmployeesRequestModel{
    var searchText = ""
    func getReqestBody()->String{
        var requestBody = ""
        if (searchText.count != 0 ){
            requestBody = "keyword=\(searchText)"
        }
        print("Request Body")
        print("-------------------------")
        print(requestBody)
        return requestBody
    }
}

