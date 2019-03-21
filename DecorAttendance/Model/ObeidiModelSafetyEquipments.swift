//
//  ObeidiModelSafetyEquipments.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 15/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit
import AFNetworking

@objcMembers
class ObeidiModelSafetyEquipments: NSObject {
    
    var id: AnyObject!
    var penalty: AnyObject!
    var intenal_name: AnyObject!
    var name: AnyObject!
    var image: AnyObject!
    
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
    class func getSafetyEquipmentsDetailsObjectArr(equipmentsDataArr: NSArray) -> NSArray? {
        if equipmentsDataArr.count > 0 {
            let detailsList = NSMutableArray()
            equipmentsDataArr.enumerateObjects ({ (obj, idx, stop) -> Void in
                let list = ObeidiModelSafetyEquipments(dictionaryDetails: obj as! NSDictionary)
                detailsList.add(list)
            })
            return detailsList
        }
        return nil
    }
    class func callSafetyEquipmentsRequest(withCompeltion completion: @escaping(Bool?, [String:AnyObject]?, NSError?) -> Void){
        let serviceName = ObeidiConstants.API.SAFETY_EQUIPMENTS
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as! String
        AFNetworkingServiceManager.sharedmanager.parseLinkUsingGetMethodAndHeader(serviceName, parameter: nil, token: accessToken){
            (success, result, error) in
            if (success! && result != nil){
                print(result as Any)
                let dict = result as! NSDictionary
                if let val = dict["error"] {
                    if case let isError as Bool = val{
                        if isError {
                            completion(false, nil, nil)
                        }else{//MARK: SUCCESS CASE
                            completion (true,result as? [String : AnyObject],nil)
                        }
                    } else {
                        
                    }
                } else {
                    print("error key is not present in dict")
                    completion(false, nil, error)
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
