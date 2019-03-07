//
//  ObeidiModelForgotPassword.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 12/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit
import AFNetworking

class ObeidiModelForgotPassword: NSObject {
    
    //    init(dictionaryDetails : NSDictionary)
    //    {
    //        super.init()
    //
    //        for (key, value) in dictionaryDetails {
    //            let keyName = key as! String
    //            let keyValue = value as AnyObject
    //
    //            if self.responds(to: Selector("\(keyName)")) == true {
    //                self.setValue(keyValue, forKey: keyName)
    //            } else {
    //                print("=====> \(keyName) == \(keyValue)")
    //                print("var \(keyName): AnyObject!")
    //            }
    //
    //        }
    //    }
    //
    //    class func getAllDetailsObjectArr(accountDataArr: NSArray) -> NSArray? {
    //        if accountDataArr.count > 0 {
    //            let detailsList = NSMutableArray()
    //            accountDataArr.enumerateObjects ({ (obj, idx, stop) -> Void in
    //                let list = IntellexModelDealManager(dictionaryDetails: obj as! NSDictionary)
    //                detailsList.add(list)
    //            })
    //            return detailsList
    //        }
    //        return nil
    //    }
    
    class func callForgotPasswordRequest(email: String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        
        let serviceName = ObeidiConstants.API.RESET_PASSWORD
        let passDict = NSMutableDictionary()
        passDict.setValue(email, forKey: "email")
        let token = UserDefaults.standard.value(forKey: "accessToken") as! String
        
        AFNetworkingServiceManager.sharedmanager.parseLinkWithHeaderUsingPostMethod(serviceName, parameter: passDict, token: token){
            (success, result, error) in
            
            if (success! && result != nil)  {
                
                print(result as Any)
                let dict = result as! NSDictionary
                
                if let val = dict["error"] {
                    if case let isError as Bool = val{
                        
                        if isError {
                            
                            completion(false, result, nil)
                        }else{
                            
                            completion(true, result, nil)
                            
                        }
                        
                    } else {
                        print("value is nil")
                    }
                } else {
                    
                    print("error key is not present in dict")
                    completion(true, result, nil)
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
    class func callAccessTokenRequest(email: String, clientID: String, resetSecret: String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        
        let serviceName = ObeidiConstants.API.ACCESS_TOKEN + "client_id=\(clientID)"
        let passDict = NSMutableDictionary()
        passDict.setValue(email, forKey: "email")
        passDict.setValue(resetSecret, forKey: "reset_secret")
        passDict.setValue(clientID, forKey: "client_id")
        AFNetworkingServiceManager.sharedmanager.parseLinkUsingPostMethod(serviceName, parameter: passDict){
            (success, result, error) in
            
            if (success! && result != nil)  {
                
                print(result as Any)
                let dict = result as! NSDictionary
                
                if let val = dict["error"] {
                    if case let isError as Bool = val{
                        
                        if isError {
                            
                            completion(false, result, nil)
                        }else{
                            
                            completion(true, result, nil)
                            
                        }
                        
                    } else {
                        print("value is nil")
                    }
                } else {
                    
                    print("error key is not present in dict")
                    completion(true, result, nil)
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
    class func callChangePasswordRequest(newPassword: String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        
        let serviceName = ObeidiConstants.API.CHANGE_PASSWORD
        let passDict = NSMutableDictionary()
        passDict.setValue(newPassword, forKey: "new_password")
        
        let token = UserDefaults.standard.value(forKey: "accessToken") as! String
        AFNetworkingServiceManager.sharedmanager.parseLinkWithHeaderUsingPostMethod(serviceName, parameter: passDict, token: token){
            (success, result, error) in
            
            if (success! && result != nil)  {
                
                print(result as Any)
                let dict = result as! NSDictionary
                
                if let val = dict["error"] {
                    if case let isError as Bool = val{
                        
                        if isError {
                            
                            completion(false, result, nil)
                        }else{
                            
                            completion(true, result, nil)
                            
                        }
                        
                    } else {
                        print("value is nil")
                    }
                } else {
                    
                    print("error key is not present in dict")
                    completion(true, result, nil)
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



