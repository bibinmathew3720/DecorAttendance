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
    
    var statusNew:Int = 0
    var locationNameNew:String = ""
    var locIdNew:Int = 0
    var bonusBudgetNew:CGFloat = 0.0
    var remainingBonusNew:CGFloat = 0.0
    var latitudeNew:Double = 0.0
    var labourCostBudgetNew:CGFloat = 0.0
    var nameNew:String = ""
    var longitudeNew:Double = 0.0
    
    
        init(dictionaryDetails : NSDictionary)
        {
            super.init()
            if let value = dictionaryDetails["STATUS"] as? Int{
                statusNew = value
            }
            if let value = dictionaryDetails["location_name"] as? String{
                locationNameNew = value
            }
            if let value = dictionaryDetails["id"] as? Int{
                locIdNew = value
            }
            if let value = dictionaryDetails["bonus_budget"] as? CGFloat{
                bonusBudgetNew = value
            }
            if let value = dictionaryDetails["remaining_bonus"] as? CGFloat{
                remainingBonusNew = value
            }
            if let value = dictionaryDetails["lat"] as? Double{
                latitudeNew = value
            }
            if let value = dictionaryDetails["labour_cost_budget"] as? CGFloat{
                labourCostBudgetNew = value
            }
            if let value = dictionaryDetails["name"] as? String{
                nameNew = value
            }
            if let value = dictionaryDetails["lng"] as? Double{
                longitudeNew = value
            }
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
    
    class func getAllSiteDetailsObjectArr(siteDataArr: NSArray) -> [ObeidiModelSites] {
        var detailsList = [ObeidiModelSites]()
        if siteDataArr.count > 0 {
            siteDataArr.enumerateObjects ({ (obj, idx, stop) -> Void in
                let list = ObeidiModelSites(dictionaryDetails: obj as! NSDictionary)
                detailsList.append(list)
            })
        }
        return detailsList
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
                            completion(true, getAllSiteDetailsObjectArr(siteDataArr: dataArr) as AnyObject, nil)
                            
                        }
                        
                    } else {
                        print("value is nil")
                    }
                } else {
                    
                    print("error key is not present in dict")
                    let dataArr = result?["result"] as! NSArray
                    completion(true, getAllSiteDetailsObjectArr(siteDataArr: dataArr) as AnyObject, nil)
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
