//
//  ApplicationController.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/24/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ApplicationController: NSObject {
    static let applicationController = ApplicationController()
    var isExpirationPopUpShowed = false
    var loginUserType:LoginUserType = .ForeMan
    private override init() {
        super.init()
        checkLoginType()
    }
    
    func checkLoginType(){
        if let roleString =  UserDefaults.standard.value(forKey: Constant.VariableNames.roleKey) as? String{
            if roleString == Constant.Names.EngineeringHead{
                loginUserType = .EngineeringHead
            }
            else if roleString == Constant.Names.Staff{
                loginUserType = .Staff
            }
            else if roleString == Constant.Names.Foreman{
                loginUserType = .ForeMan
            }
        }
    }
}
