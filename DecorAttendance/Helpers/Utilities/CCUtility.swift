//
//  CCUtility.swift
//  CCLUB
//
//  Created by Albin Joseph on 2/7/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import UIKit

class CCUtility: NSObject {
    class func getJSONfrom(dictionary:[String:Any?]) -> String {
        var jsonString:String?
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            
            jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
        } catch {
            print(error.localizedDescription)
        }
        guard let requestBody = jsonString else {
            return ""
        }
        return requestBody
    }
    
    
    class func showDefaultAlertwith(_title : String, _message : String, parentController : UIViewController){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")

            case .cancel:
                print("cancel")

            case .destructive:
                print("destructive")
            }
        }))
        parentController.present(alert, animated: true, completion: nil)
    }
    
    
    
   class func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    class func showDefaultAlertwithCompletionHandler(_title : String, _message : String, parentController : UIViewController, completion:@escaping (_ okSuccess:Bool)->()){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            completion(true)
            switch action.style{
                
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }
        }))
        parentController.present(alert, animated: true, completion: nil)
    }
    
    class func showActionAlertwithCancel(_title : String, _message : String, parentController : UIViewController,action:UIAlertAction){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { action in
            //  alert.dismiss(animated: true, completion: )
        }))
        parentController.present(alert, animated: true, completion: nil)
        
    }
    
   class func showAlertWithYesOrCancel(_title : String, viewController:UIViewController, messageString:String, completion:@escaping (_ result:Bool) -> Void) {
    
        let alertController = UIAlertController(title: _title, message: messageString, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
           
            completion (true)
        }
        let noAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
            completion (false)
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        viewController.present(alertController, animated: true) {
        }
    }
    
    class func showAlertForCameraSettings(_title : String, viewController:UIViewController, messageString:String, completion:@escaping (_ result:Bool) -> Void) {
        
        let alertController = UIAlertController(title: _title, message: messageString, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action:UIAlertAction) in
            completion (true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
            completion (false)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        viewController.present(alertController, animated: true) {
        }
    }
    
    class func showAlertWithoutOkOrCancel(_title : String, viewController:UIViewController, messageString:String, completion:@escaping () -> Void) {
        let alertController = UIAlertController(title: _title, message: messageString, preferredStyle: .alert)
        viewController.present(alertController, animated: true) {
        }
    }
    
    class func showActionAlertwith(_title : String, _message : String, parentController : UIViewController,action:UIAlertAction){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(action)
        
        parentController.present(alert, animated: true, completion: nil)
        
    }
    
    class func openSocialLink(_url : String){
        if let url = URL(string: _url) {
            if #available(iOS 10, *){
                UIApplication.shared.open(url)
            }else{
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    class func showActionAlertForSessionTimeOut(parentController : UIViewController,statusMessage:String){
        let alertController = UIAlertController(title: User.AppName, message: statusMessage, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            CCUtility.processAfterLogOut()
            let delegate = UIApplication.shared.delegate as! AppDelegate
        }
        alertController.addAction(yesAction)
        parentController.present(alertController, animated: true) {
        }
    }
    
   
    
   class func getErrorTypeFromStatusCode(errorValue : Int) -> StatusEnum {
        switch errorValue {
        case (200...299):
            return .success
        case 401:
            return .sessionexpired
        case (400...499):
            return .missing
        case (500...599):
            return .server
        default:
            return .server
        }
    }
    
    class func stringFromDate(date : Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    class func dateString(with dateString : String,from dateFormat:String, to format:String) -> String
    {
        
        if dateString == "0000-00-00" || dateString == ""
        {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = format
        let dateStr = dateFormatter.string(from:date!)
        return dateStr
    }
    
    class func date(from dateString : String, to format:String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format //Your date format
       // dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        let date = dateFormatter.date(from: dateString)
        guard let _date = date else {
            return Date()
        }
        return _date
    }
    
    class func convertToDateToFormat(inputDate:String,inputDateFormat:String,outputDateFormat:String)->String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputDateFormat
        let showDate = inputFormatter.date(from: inputDate)
        inputFormatter.dateFormat = outputDateFormat
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
        
    }
    
    class func processAfterLogIn(){
      
    }
    
    class func guestSwitchingAfterSignUp(){
       
    }
    
    class func processAfterLogOut(){
        UserDefaults.standard.setValue("", forKey: "accessToken")
        UserDefaults.standard.set(false, forKey: Constant.VariableNames.isLoggedIn)
    }
    
    class func getCurrentLanguage()->String{
        let language = UserDefaults.standard.value(forKey: "language")
        if let _language = language as? String{
            return _language
        }else{
            return "en"
        }
    }
    
    class func getAttendanceTypeString(attendanceType:AttendanceType)->String{
        switch attendanceType {
        case .StartTime:
            return "start_time"
        case .EndTime:
            return "end_time"
        case .SickLeave:
            return "sick_leave"
        case .Absent:
            return "absent"
        case .Strike:
            return "strike"
        }
    }
    
}
