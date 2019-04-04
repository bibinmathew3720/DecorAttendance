//
//  ObeidiModelLogin.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 12/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit
import AFNetworking

class ObeidiModelLogin: NSObject {
    
    
    class func callLoginRequest(bodyDict: NSMutableDictionary!, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void) {
        let serviceName = ObeidiConstants.API.LOGIN
        AFNetworkingServiceManager.sharedmanager.parseLinkUsingPostMethod(serviceName, parameter: bodyDict) {
            (success, result, error) in
            if (success! && result != nil)  {
                print(result as Any)
                let dict = result as! NSDictionary
                if let val = dict["error"] {
                    if case let isError as Bool = val{
                        if isError {
                            completion(false, result, nil)
                        }
                    } else {
                        print("value is nil")
                    }
                } else {
                    print("error key is not present in dict")
                    if let res = result as? [String : Any?]{
                        completion(true, LoginResponseModel.init(dict: res), nil)
                    }
                    else{
                       completion(false, result, nil)
                    }
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

class LoginResponseModel:NSObject{
    var email:String = ""
    var empId:Int = 0
    var personId:Int = 0
    var roles = [String]()
    var status:Int = 0
    var token:String = ""
    var userName:String = ""
    
    init(dict:[String:Any?]) {
        if let value = dict["email"] as? String{
            email = value
        }
        if let value = dict["id"] as? Int{
            empId = value
        }
        if let value = dict["person_id"] as? Int{
            personId = value
        }
        if let value = dict["roles"] as? NSArray{
            for item in value{
                if let it = item as? String{
                    roles.append(it)
                }
            }
        }
        if let value = dict["status"] as? Int{
            status = value
        }
        if let value = dict["token"] as? String{
            token = value
        }
        if let value = dict["username"] as? String{
            userName = value
        }
    }
}
