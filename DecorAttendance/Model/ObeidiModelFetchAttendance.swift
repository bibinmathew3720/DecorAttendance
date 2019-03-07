//
//  ObeidiModelFetchAttendance.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 15/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit
import AFNetworking

@objcMembers
class ObeidiModelFetchAttendance: NSObject {
    
    
    var bonus_amount: AnyObject!
    var emp_id: AnyObject!
    var is_strike: AnyObject!
    var is_present: AnyObject!
    var end_time_marked_at: AnyObject!
    var is_attendance_completed: AnyObject!
    var is_sick_leave: AnyObject!
    var image: AnyObject!
    var is_approved: AnyObject!
    var start_time_marked_at: AnyObject!
    var attendance_id: AnyObject!
    var name: AnyObject!
    var start_time_marked: AnyObject!
    var end_time_marked: AnyObject!
   
    
    
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
    
    class func callfetchAtendanceRequset(isAttendanceCompleted: Int, date: String, keyword: String, siteId: String, withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        
        let serviceName: String!
        serviceName = ObeidiConstants.API.FETCH_ATTENDANCE + "?is_attendance_completed=\(isAttendanceCompleted)&keyword=\(keyword)&site_id=\(siteId)&date=\(date)"
        
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
