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
