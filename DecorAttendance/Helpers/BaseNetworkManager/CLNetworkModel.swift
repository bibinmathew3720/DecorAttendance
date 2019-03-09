//
//  CLNetworkModel.swift
//  CCLUB
//
//  Created by Albin Joseph on 2/7/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import UIKit

enum ErrorType : Int {
    case noNetwork = 1
    case dataError
    case notFound
    case internalServerError
}

enum StatusEnum : Int {
    case success
    case missing
    case server
    case sessionexpired
}

class CLNetworkModel: NSObject {
    var requestURL: String?
    var requestMethod: String?
    var requestBody: String?
    var requestHeader: [String : String]?
    
    init(url : String, requestMethod_ : String){
        requestURL = url
        requestMethod = requestMethod_
        //let user = User.getUser()
        requestHeader = [String : String]()
        _ = requestHeader?.updateValue("application/json", forKey: "Content-Type")
//        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
//        if let appVer = appVersion {
//            _ = requestHeader?.updateValue(appVer, forKey: "App-Version")
//        }
//        else{
//            _ = requestHeader?.updateValue("1.0", forKey: "App-Version")
//        }
//         _ = requestHeader?.updateValue("1", forKey: "PlatForm")
//        if (CCUtility.getCurrentLanguage() == "en") {
//            _ = requestHeader?.updateValue("1", forKey: "Language")
//        }
//        else {
//            _ = requestHeader?.updateValue("2", forKey: "Language")
//        }
//        if let _sessionToken = user?.sessionToken{
//            _ = requestHeader?.updateValue(_sessionToken, forKey: "Session-Token")
//        }
//        else{
//           _ = requestHeader?.updateValue(Constant.GuestToken, forKey: "Session-Token")
//        }
    }
}
