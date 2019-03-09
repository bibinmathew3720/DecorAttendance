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
        requestHeader = [String : String]()
        _ = requestHeader?.updateValue("application/json", forKey: "Content-Type")
        if let _token = UserDefaults.standard.string(forKey: "accessToken"){
           _ = requestHeader?.updateValue("Bearer " + _token , forKey: "Authorization")
        }

}
}
