//
//  PhotoCheckViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 28/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class PhotoCheckViewController: UIViewController, dismissDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var imageViewDataBase: UIImageView!
    @IBOutlet weak var imageViewSnapShot: UIImageView!
    @IBOutlet weak var bttnTakePhotoAgain: UIButton!
    @IBOutlet weak var bttnDone: UIButton!
    
    
    var capturedImageRef: UIImage!
    var paramsDict = NSMutableDictionary()
    var spinner = UIActivityIndicatorView(style: .gray)
    var imageData: Data!
    
    var selSiteModel:ObeidiModelSites?
    var attendanceResponse:ObeidiModelFetchAttendance?
    var attendanceType:AttendanceType?
    var penaltyValue:CGFloat?
    var selLocation:Location?
    var missedSafetyEquipments = [SafetyEquipment]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewStyles()
        initialisation()
        //set image from database
        populateData()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
        self.title = Constant.PageNames.Attendance
         self.navigationController?.navigationItem.leftBarButtonItem?.title = ""
    }
    
    func populateData(){
        if let selAttendance = self.attendanceResponse{
            if let imageUrl = URL(string: selAttendance.profileBaseUrl+selAttendance.profileImageUrl){
                self.imageViewDataBase.setImageWith(imageUrl, placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
            }
        }
    }
    
    func setViewStyles()  {
        self.imageViewSnapShot.image = capturedImageRef
        let bttnTakePhoto = self.bttnTakePhotoAgain!
        bttnTakePhoto.layer.cornerRadius = self.bttnTakePhotoAgain.frame.size.height / 2
        bttnTakePhoto.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        bttnTakePhoto.layer.shadowOffset = CGSize(width: 0, height: 8)
        bttnTakePhoto.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        bttnTakePhoto.layer.shadowOpacity = 1
        bttnTakePhoto.layer.shadowRadius = self.bttnTakePhotoAgain.frame.size.height / 2
        
        let bttnDone = self.bttnDone!
        bttnDone.layer.cornerRadius = self.bttnDone.frame.size.height / 2
        bttnDone.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        bttnDone.layer.shadowOffset = CGSize(width: 0, height: 8)
        bttnDone.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        bttnDone.layer.shadowOpacity = 1
        bttnDone.layer.shadowRadius = self.bttnDone.frame.size.height / 2
    }
    
    
    @IBAction func bttnActnTakePhotoAgain(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bttnActnDone(_ sender: Any) {
        if User.Attendance.type == User.attendanceType.endTime {
            if let roleString =  UserDefaults.standard.value(forKey: Constant.VariableNames.roleKey) as? String{
                if roleString == Constant.Names.Staff{
                    callPostAttendanceAPI()
                }
                else{
                   self.performSegue(withIdentifier: "toEndTimeBonusSceneSegue:PhotoCheck", sender: (Any).self)
                }
            }
        }else{
            callPostAttendanceAPI()
        }
    }
    
    func callPostAttendanceAPI()  {
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        ObeidiModelMarkAttendance.callMarkAttendanceRequest(dataDict: getParamsDict(), image: self.imageData){
            (success, result, error) in
            if success! {
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                print(result!)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let alertController = storyboard.instantiateViewController(withIdentifier: "ObeidiAlertViewControllerID") as! ObeidiAlertViewController
                
                alertController.titleRef = "Success ."
                alertController.explanationRef = "Your Attendance has been marked. "
                alertController.parentController = self
                
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                alertController.delegate = self
                self.present(alertController, animated: true, completion: nil)
            }else{
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            }
        }
    }
    
    func getParamsDict() -> NSMutableDictionary {
        if let penalty = self.penaltyValue {
            paramsDict.setValue("\(penalty)", forKey: "penalty")
        }
        if let siteModel = self.selSiteModel{
            paramsDict.setValue("\(siteModel.locIdNew)", forKey: "site_id")
        }
        if let location = self.selLocation{
            paramsDict.setValue("\(location.latitude)", forKey: "lat")
            paramsDict.setValue("\(location.longitude)", forKey: "lng")
        }
        if let attType = self.attendanceType{
             paramsDict.setValue(CCUtility.getAttendanceTypeString(attendanceType:attType), forKey: "type")
            if (attType == AttendanceType.StartTime){
                var equipmentIdArray = [Int]()
                for item in self.missedSafetyEquipments{
                    equipmentIdArray.append(item.id)
                }
               paramsDict.setValue(equipmentIdArray, forKey: "safety_equipments_missed")
            }
        }
        if (ApplicationController.applicationController.loginUserType != .Staff){
            if let attResponse = self.attendanceResponse{
                paramsDict.setValue("\(attResponse.empId)", forKey: "emp_id")
            }
            paramsDict.setValue("0", forKey: "bonus")
            paramsDict.setValue(capturedImageRef, forKey: "image")
        }
        print(paramsDict)
        return paramsDict
    }
    
    func dismissed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEndTimeBonusSceneSegue:PhotoCheck"{
            let vc = segue.destination as! EndTimeBonusViewController
            vc.selSiteModel = self.selSiteModel
            vc.attendanceResponse = self.attendanceResponse
            vc.attendanceType = self.attendanceType
            vc.selLocation = self.selLocation
            vc.imageDataRef = self.imageData
        }
    }
}

class Location:NSObject{
    var latitude:Double = 0.0
    var longitude:Double = 0.0
}
