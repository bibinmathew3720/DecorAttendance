//
//  ObeidiModelSites.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 12/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit
import AFNetworking

@objcMembers
class ObeidiModelSites: NSObject {
  
    var status: AnyObject!
    var location_name: AnyObject!
    var id: AnyObject!
    var created_at: AnyObject!
    var bonus_budget: AnyObject!
    var modified_at: AnyObject!
    var lat: AnyObject!
    var labour_cost_budget: AnyObject!
    var name: AnyObject!
    var lng: AnyObject!
    var STATUS: AnyObject!
    var remaining_bonus: AnyObject!
    
    
        init(dictionaryDetails : NSDictionary)
        {
            super.init()
    
            for (key, value) in dictionaryDetails {
                let keyName = key as! String
                let keyValue = value as AnyObject
    
                if self.responds(to: Selector("\(keyName)")) == true {
                    self.setValue(keyValue, forKey: keyName)
                } else {
                    print("=====> \(keyName) == \(keyValue)")
                    print("var \(keyName): AnyObject!")
                }
    
            }
        }
    
        class func getAllSiteDetailsObjectArr(siteDataArr: NSArray) -> NSArray? {
            if siteDataArr.count > 0 {
                let detailsList = NSMutableArray()
                siteDataArr.enumerateObjects ({ (obj, idx, stop) -> Void in
                    let list = ObeidiModelSites(dictionaryDetails: obj as! NSDictionary)
                    detailsList.add(list)
                })
                return detailsList
            }
            return nil
        }
    
    class func callListSitesRequset(withCompletion completion: @escaping(Bool?, AnyObject?, NSError?) -> Void){
        
        let serviceName = ObeidiConstants.API.GET_ALL_SITES
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
                            let dataArr = result?["result"] as! NSArray
                            completion(true, getAllSiteDetailsObjectArr(siteDataArr: dataArr), nil)
                            
                        }
                        
                    } else {
                        print("value is nil")
                    }
                } else {
                    
                    print("error key is not present in dict")
                    let dataArr = result?["result"] as! NSArray
                    completion(true, getAllSiteDetailsObjectArr(siteDataArr: dataArr), nil)
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
