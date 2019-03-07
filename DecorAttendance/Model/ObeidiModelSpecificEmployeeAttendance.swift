//
//  ObeidiModelSpecificEmployeeAttendance.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 21/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ObeidiModelSpecificEmployeeAttendance: NSObject {
    
    
    init(dictionaryDetails : NSDictionary)
    {
        super.init()
        
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
    class func getAttendanceDetailsObjectArr(attendanceDataArr: NSArray) -> NSArray? {
        if attendanceDataArr.count > 0 {
            let detailsList = NSMutableArray()
            attendanceDataArr.enumerateObjects ({ (obj, idx, stop) -> Void in
                let list = ObeidiModelFetchAttendance(dictionaryDetails: obj as! NSDictionary)
                detailsList.add(list)
            })
            return detailsList
        }
        return nil
    }
    
    class func callAtendanceDetailsByIDRequset(attendanceId: String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        
        let serviceName: String!
        serviceName = ObeidiConstants.API.FETCH_ATTENDANCE + "/\(attendanceId)"
        
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
                            let imageBase = dataDict["image_base"] as! String
                            UserDefaults.standard.set(imageBase, forKey: "attendanceImageBase")
                            let dataArr = dataDict["result"] as! NSArray
                            completion(true, getAttendanceDetailsObjectArr(attendanceDataArr: dataArr), nil)
                            
                        }
                        
                    } else {
                        print("value is nil")
                    }
                } else {
                    
                    print("error key is not present in dict")
                    let dataDict = result as! NSDictionary
                    completion(false, dataDict, error)
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
