//
//  MarkAttendanceViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 28/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit
import Kingfisher
import CoreLocation
import MapKit

enum AttendanceType{
    case StartTime
    case EndTime
    case SickLeave
    case Absent
    case Strike
}

enum LoginUserType{
    case ForeMan
    case Staff
    case EngineeringHead
}

let startTime = "Start Time"
let endTime = "End Time"
let sickLeave = "Sick Leave"
let absent = "Absent"
let strike = "Strike"

class MarkAttendanceViewController: UIViewController, DropDownDataDelegate, filterUpdatedDelegate,dismissDelegate {

    @IBOutlet weak var bttnNext: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var imageEmployee: UIImageView!
    @IBOutlet weak var lblSiteSelection: UILabel!
    @IBOutlet weak var stateHeadingLabel: UILabel!
    @IBOutlet weak var lblAttendanceSelection: UILabel!
    
    var spinner = UIActivityIndicatorView(style: .gray)
    
    var attendanceResponse:ObeidiModelFetchAttendance?
    var siteModelObjArr = [ObeidiModelSites]()
    var selSiteModel:ObeidiModelSites?
    var selAttendanceType:String?
    var attendanceType:AttendanceType?
    var addAttendanceRequest = AddAttendanceRequestModel()
    
    var locationManager: CLLocationManager! = nil
    var selLocation:Location?
    var loginUserType:LoginUserType = .ForeMan
    
    //For Staff Login
    var listingRequest = ReportListingRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        setViewStyles()
        addTapGesturesToLabels()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
       self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        setUIContents()
        locationManager = CLLocationManager()
        askForLocationAuthorisation()
        // Do any additional setup after loading the view.
        if loginUserType == .Staff{
            initialisatingStaffLogin()
            callingReportListingAPI()
        }
    }
    
    func initialisatingStaffLogin(){
        self.lblName.isHidden = true
        self.lblID.isHidden = true
        lblSiteSelection.isHidden = true
        stateHeadingLabel.isHidden = true
        
        if let _year = Date().getComponents().year{
            listingRequest.startYear = _year
            listingRequest.endYear = _year
        }
        if let _month = Date().getComponents().month{
            listingRequest.startMonth = _month
            listingRequest.endMonth = _month
        }
        if let _day = Date().getComponents().day{
            listingRequest.startDay = _day
            listingRequest.endDay = _day
        }
        
    }
    
    func callingReportListingAPI(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        StaffManager().getReportListingApi(with: listingRequest.getRequestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _model = model as? ObeidAttendanceResponseModel{
                if _model.error == 0{
                    if _model.attendanceResultArray.count > 0{
                        self.attendanceResponse = _model.attendanceResultArray.first
                        self.setUIContents()
                        
                    }
                    else{
                         guard let encodedUrlstring = (_model.imageBaseUrl+_model.imageUrl).addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else { return  }
                        if let imageUrl = URL(string: encodedUrlstring){
                            self.imageEmployee.setImageWith(imageUrl, placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
                        }
                    }
                }
                self.initialisation()
            }
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: User.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: User.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            print(ErrorType)
        }
    }
    
    func initialisation(){
        self.title = Constant.PageNames.Attendance
        if let attendanceType = fetchAttendanceTypeArr().firstObject as? String{
            self.selAttendanceType = attendanceType
        }
        else{
            self.selAttendanceType = nil
            self.attendanceType = nil
        }
       populateSelectedSite()
       populateAttendanceType()
    }
    
    func askForLocationAuthorisation(){
        // Ask for Authorisation from the User.
        //self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func populateSelectedSite(){
        if let selSite = self.selSiteModel{
            self.lblSiteSelection.text = selSite.nameNew
        }
    }
    
    func populateAttendanceType(){
        if let selAttType = self.selAttendanceType{
            self.lblAttendanceSelection.text = selAttType
            if selAttType == startTime{
                self.attendanceType = AttendanceType.StartTime
            }
            else if selAttType == endTime{
                self.attendanceType = AttendanceType.EndTime
            }
            else if selAttType == sickLeave{
                self.attendanceType = AttendanceType.SickLeave
            }
            else if selAttType == absent{
                self.attendanceType = AttendanceType.Absent
            }
            else if selAttType == strike{
                self.attendanceType = AttendanceType.Strike
            }
        }
        else{
            self.lblAttendanceSelection.text = ""
        }
    }
    
    func setUIContents()  {
        if let attResponse = attendanceResponse{
            print(attResponse.profileBaseUrl+attResponse.profileImageUrl)
            guard let encodedUrlstring = (attResponse.profileBaseUrl+attResponse.profileImageUrl).addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else { return  }
            if let imageUrl = URL(string: encodedUrlstring){
                self.imageEmployee.setImageWith(imageUrl, placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
            }
            addAttendanceRequest.empId = attResponse.empId
            self.lblName.text = attResponse.name
            self.lblID.text = "OAA\(attResponse.empId)"
        }
    }

    func setViewStyles() {
        let layer = self.bttnNext!
        layer.layer.cornerRadius = self.bttnNext.frame.size.height / 2
        layer.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        layer.layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        layer.layer.shadowOpacity = 1
        layer.layer.shadowRadius = self.bttnNext.frame.size.height / 2
    
        self.lblSiteSelection.layer.cornerRadius = 1
        self.lblSiteSelection.layer.borderWidth = 0.5
        self.lblSiteSelection.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblAttendanceSelection.layer.cornerRadius = 1
        self.lblAttendanceSelection.layer.borderWidth = 0.5
        self.lblAttendanceSelection.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: self.lblName, fontSize: ObeidiFont.Size.mediumA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.boldFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: self.lblID, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: self.lblAttendanceSelection, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiLightBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: self.lblSiteSelection, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiLightBlack(), fontName: ObeidiFont.Family.normalFont())
    }
    
    func addTapGesturesToLabels() {
        self.lblAttendanceSelection.isUserInteractionEnabled = true
        let tapGestureAttendance = UITapGestureRecognizer(target: self, action: #selector(MarkAttendanceViewController.handleAttendanceLabelTap))
        self.lblAttendanceSelection.addGestureRecognizer(tapGestureAttendance)
        
        self.lblSiteSelection.isUserInteractionEnabled = true
        let tapGestureSite = UITapGestureRecognizer(target: self, action: #selector(MarkAttendanceViewController.handleSiteLabelTap))
        self.lblSiteSelection.addGestureRecognizer(tapGestureSite)
    }
    
    @objc func handleAttendanceLabelTap(){
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    //self.view.alpha = 0.65
                    //self.tabBarController?.view.alpha = 0.65
                    // self.navigationController?.navigationBar.alpha = 0.65
                    
                    
                },completion:nil)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let attendanceTypeController = storyboard.instantiateViewController(withIdentifier: "POPUPSelectorViewControllerID") as! POPUPSelectorViewController
                attendanceTypeController.delegate = self
                //calendarViewController.isDateNeeded = true
                attendanceTypeController.filterTypeName = FilterTypeName.attendanceType
                attendanceTypeController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                attendanceTypeController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                attendanceTypeController.filterDataArr = self.fetchAttendanceTypeArr()
                self.present(attendanceTypeController, animated: true, completion: nil)
                
            }
    }
    
    @objc func handleSiteLabelTap(){
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //self.view.alpha = 0.65
                //self.tabBarController?.view.alpha = 0.65
               // self.navigationController?.navigationBar.alpha = 0.65
                
                
            },completion:nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let siteViewController = storyboard.instantiateViewController(withIdentifier: "POPUPSelectorViewControllerID") as! POPUPSelectorViewController
            siteViewController.delegate = self
            //calendarViewController.isDateNeeded = true
            siteViewController.filterTypeName = FilterTypeName.site
            siteViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            siteViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            siteViewController.sitesArray = self.siteModelObjArr
            self.present(siteViewController, animated: true, completion: nil)
        }
    }
    
    func filterValueUpdated(to value: AnyObject!, updatedType: FilterTypeName!) {
        
        switch updatedType! {
        case .site:
            print("")
//            self.lblSiteSelection.text = ((value as! NSMutableDictionary).value(forKey: "name") as! String)
        case .attendanceType:
            print("")
            if let val = value as? String{
                self.selAttendanceType = val
                populateAttendanceType()
            }
           
        default:
            print("")
        }
    }
    
    func dateUpdated(to date: String, updatedType: FilterTypeName!) {
    
    }
    
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName) {
        self.selSiteModel = selSite
        populateSelectedSite()
    }
    
    func doneButtonActionDelegateWithSelectedDate(date: String, type: FilterTypeName,dateInDateFormat:Date) {
        
    }
    
    func calendarColsed() {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.alpha = 1
            //self.tabBarController?.view.alpha = 0.65
            self.navigationController?.navigationBar.alpha = 1
            
            
        },completion:nil)
        
        
    }
    func presentDropDownController(tableCgPoint: CGPoint, dropDownFor:
        DropDownNeededFor, arr: NSMutableArray) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dropDownController = storyboard.instantiateViewController(withIdentifier: "DropDownViewControllerID") as! DropDownViewController
        dropDownController.tableCgPoint = tableCgPoint//CGPoint(x: self.viewDropDownButtons.frame.minX, y: self.viewDropDownButtons.frame.maxY) //+ (self.navigationController?.navigationBar.frame.size.height)!)
        dropDownController.widthTable = self.lblAttendanceSelection.frame.size.width
        dropDownController.dropDownNeededFor = dropDownFor
        dropDownController.delegate = self
        switch dropDownFor {
            
        case DropDownNeededFor.Date:
            dropDownController.dateArr = arr
            dropDownController.dropDownNeededFor = dropDownFor
        case DropDownNeededFor.Month:
            dropDownController.monthArr = arr
            dropDownController.dropDownNeededFor = dropDownFor
        case DropDownNeededFor.Site:
            dropDownController.siteArr = arr
            dropDownController.dropDownNeededFor = dropDownFor
            
        case .Attendance:
            dropDownController.attendanceArr = arr
            dropDownController.dropDownNeededFor = dropDownFor
        }
        
        dropDownController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        dropDownController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(dropDownController, animated: true, completion: nil)
        
        
    }
    func fetchAttendanceTypeArr() -> NSMutableArray {
        var arr = NSMutableArray()
        if let attResponse = attendanceResponse{
            if loginUserType == .Staff{
                if attResponse.isSickLeave || attResponse.isStrike || !attResponse.isPresent{
                    return []
                }
                else if (attResponse.isStartTimeMarked && attResponse.isEndTimeMarkd){
                     return []
                }
            }
            arr = [startTime, endTime, sickLeave, absent, strike]
            if !attResponse.isStartTimeMarked{
                arr = [startTime, sickLeave, absent, strike]
            }
            else if attResponse.isStartTimeMarked{
                arr = [endTime, sickLeave]
            }
            else{
                arr = [startTime, endTime, sickLeave, absent, strike]
            }
            
        }
        else{
            if self.loginUserType == .Staff{
                arr = [startTime, endTime, sickLeave, absent, strike]
            }
        }
        return arr
    }
    
    func getPointForSiteTable() -> CGPoint{
        
        return CGPoint(x: self.lblSiteSelection.frame.minX, y:   self.lblSiteSelection.frame.maxY + self.lblSiteSelection.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)!)
        
    }
    func getPointForAttendanceTable() -> CGPoint{
        
        return CGPoint(x: self.lblAttendanceSelection.frame.minX, y: self.lblAttendanceSelection.frame.maxY + self.lblAttendanceSelection.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)!)
        
    }
    
    func changedValue(is value: String!, dropDownType: DropDownNeededFor, index: Int) {
        
       
    }

    @IBAction func bttnActnNext(_ sender: Any) {
        if let _selLocation = self.selLocation{
            if let attType = self.attendanceType{
                switch attType{
                case .StartTime:
                    self.performSegue(withIdentifier: "toSafetyEquipmentsSceneSegue:MarkAttendance", sender: Any.self)
                    break
                case .EndTime:
                    User.Attendance.type = User.attendanceType.endTime
                    self.performSegue(withIdentifier: "toCaptureImageSceneSegue:MarkAttendanceScene", sender: Any.self)
                    break
                case .SickLeave:
                    self.performSegue(withIdentifier: "toSickLeaveSceneSegue:MarkAttendance", sender: Any.self)
                    break
                case .Absent:
                    if inValidEntry(){
                        callPostAttendanceAPI()
                    }
                    break
                case .Strike:
                    if inValidEntry(){
                        callPostAttendanceAPI()
                    }
                    break
                }
            }
            else{
                if loginUserType == .Staff{
                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "Attendance already marked", parentController: self)
                }
            }
        }
        else{
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "Location Not Available", parentController: self)
        }
    }
    
    func showObeidiAlert(message: String, title: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let alertController = storyboard.instantiateViewController(withIdentifier: "ObeidiAlertViewControllerID") as! ObeidiAlertViewController
        
        alertController.titleRef = title
        alertController.explanationRef = message
        alertController.parentController = self
        alertController.delegate = self
        alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Alert Controller Delegate
    
    func dismissed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSafetyEquipmentsSceneSegue:MarkAttendance"{
            let vc = segue.destination as! SafetyEquipmentsViewController
            vc.selSiteModel = self.selSiteModel
            vc.attendanceResponse = self.attendanceResponse
            vc.attendanceType = self.attendanceType
            vc.selLocation = self.selLocation

        }
        else if segue.identifier == "toCaptureImageSceneSegue:MarkAttendanceScene"{
            let vc = segue.destination as! CaptureImageViewController
            vc.selSiteModel = self.selSiteModel
            vc.attendanceResponse = self.attendanceResponse
            vc.attendanceType = self.attendanceType
            vc.selLocation = self.selLocation
            vc.attendanceResponse = self.attendanceResponse
        }
        else if segue.identifier == "toSickLeaveSceneSegue:MarkAttendance"{
            let vc = segue.destination as! SickLeaveViewController
            vc.selSiteModel = self.selSiteModel
            vc.attendanceType = self.attendanceType
            vc.selLocation = self.selLocation
            vc.attendanceResponse = self.attendanceResponse
        }
    }
    
    //Calling post attendance api
    
    func callPostAttendanceAPI()  {
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        if let atType = self.attendanceType{
            addAttendanceRequest.type = CCUtility.getAttendanceTypeString(attendanceType: atType)
        }
        if let selSite = self.selSiteModel{
            addAttendanceRequest.siteId = selSite.locIdNew
        }
        LabourManager().addAttendance(with:addAttendanceRequest.getRequestBody(), success: {
            (model,response)  in
            ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            if let model = model as? AddAttendanceResponseModel{
                if model.error == 0{
                    if let att = self.attendanceType{
                        if att == AttendanceType.Absent{
                           self.showObeidiAlert(message: "Absent has been marked", title: "Success")
                        }
                        else if att == AttendanceType.Strike{
                            self.showObeidiAlert(message: "Strike has been marked", title: "Success")
                        }
                    }
                }
                else{
                    CCUtility.showDefaultAlertwith(_title: User.AppName, _message: "", parentController: self)
                }
            }
            
        }) { (ErrorType) in
            ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: User.AppName, _message: User.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: User.AppName, _message: User.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            
            print(ErrorType)
        }
    }
    
    func inValidEntry()->Bool{
        var valid = true
        if let selLocation = self.selLocation{
        }
        else{
            valid = false
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "Location not found", parentController: self)
        }
        return valid
    }
}

//MARK: location delegate

extension MarkAttendanceViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        selLocation = Location()
        selLocation?.latitude = locValue.latitude
        selLocation?.longitude = locValue.longitude
        self.addAttendanceRequest.location = selLocation
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error.localizedDescription)
    }
}
