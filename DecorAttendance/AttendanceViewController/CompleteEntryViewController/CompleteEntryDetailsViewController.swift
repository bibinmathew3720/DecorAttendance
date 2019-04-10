//
//  CompleteEntryDetailsViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 01/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//


import UIKit
import MapKit
import GoogleMaps
import CoreLocation

class CompleteEntryDetailsViewController: UIViewController {
    
    
    var latOrignlRef: String!
    var lngOriginlRef: String!
    var latCapturedRef: String!
    var lngCapturedRef: String!
    
     var selectedSite: ObeidiModelSites?
    var attendanceDetails:ObeidiModelFetchAttendance?
    var attendanceId:Int?
    var updateAttendanceStatus = ChangeAttendanceStatusRequestModel()
    
    @IBOutlet weak var firstLocationLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var startTimeLocationLabel: UILabel!
    @IBOutlet weak var startTimeStackView: UIStackView!
    @IBOutlet weak var startTimeImageView: UIImageView!
    @IBOutlet weak var endTimeHeadingStackView: UIStackView!
    @IBOutlet weak var endTimeLocationLabel: UILabel!
    @IBOutlet weak var endTimeImageview: UIImageView!
    @IBOutlet weak var endTimeStackView: UIStackView!
    
    @IBOutlet weak var addBonusButton: UIButton!
    @IBOutlet weak var addBonusStackView: UIStackView!
    @IBOutlet weak var disApproveButton: UIButton!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var disApproveStackView: UIStackView!
    @IBOutlet weak var approveStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        populateAttendanceDetails()
        if let _attendanceDetails = self.attendanceDetails{
            callingAttendanceDetailAPI(attendanceId: "\(_attendanceDetails.attendanceId)")
        }
        if let site = self.selectedSite{
            self.getAddressStringfFrom(latitude: site.latitudeNew, longitude: site.longitudeNew) { (status, addressString, error) in
                if let address = addressString{
                    self.firstLocationLabel.text = address
                }
            }
        }
        if let _attendanceId = self.attendanceId{
            updateAttendanceStatus.attendanceId =  _attendanceId
        }
        // setViewStyles()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
    }
    
    func initialisation(){
        settingRedBackgroundToButton(button: self.disApproveButton)
        settingGreenBackgrounfToButton(button: self.approveButton)
        settingRedBackgroundToButton(button: addBonusButton)
        if let roleString =  UserDefaults.standard.value(forKey: Constant.VariableNames.roleKey) as? String{
            if roleString == Constant.Names.Foreman{
                approveStackView.isHidden = true
                disApproveStackView.isHidden = true
            }
        }
        
    }
    
    func settingRedBackgroundToButton(button:UIButton){
        button.backgroundColor = Constant.Colors.commonRedColor
    }
    
    func settingGreenBackgrounfToButton(button:UIButton){
        button.backgroundColor  = Constant.Colors.commonGreenColor
    }
    
    func populateAttendanceDetails(){
        if let _attendanceDetails = self.attendanceDetails{
            if let imageUrl = URL(string: _attendanceDetails.profileImageUrl){
                self.userProfileImageView.setImageWith(imageUrl, placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
            }
            if let imageUrl = URL(string: _attendanceDetails.imageBaseUrl + _attendanceDetails.startTimeImage){
                self.startTimeImageView.setImageWith(imageUrl, placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
            }
            if let imageUrl = URL(string: _attendanceDetails.imageBaseUrl + _attendanceDetails.endTimeImage){
                self.endTimeImageview.setImageWith(imageUrl, placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
            }
            if (_attendanceDetails.isPresent){
                self.statusLabel.text = "Start Time"
                self.getAddressStringfFrom(latitude: _attendanceDetails.startTimeLatitude, longitude: _attendanceDetails.startTimeLongitude) { (status, addressString, error) in
                    if let address = addressString{
                        self.startTimeLocationLabel.text = address
                    }
                }
                self.getAddressStringfFrom(latitude: _attendanceDetails.endTimeLatitude, longitude: _attendanceDetails.endTimeLongitude) { (status, addressString, error) in
                    if let address = addressString{
                        self.endTimeLocationLabel.text = address
                    }
                }
            }
            else{
                self.statusLabel.text = "Absent"
                self.startTimeStackView.isHidden = true
                self.endTimeStackView.isHidden = true
                self.endTimeHeadingStackView.isHidden = true
            }
            if _attendanceDetails.isApproved == 1{
                disApproveStackView.isHidden = true
                approveButton.isSelected = true
            }
            else if (_attendanceDetails.isApproved == 0){
                approveStackView.isHidden = true
                disApproveButton.isSelected = true
            }
            else{
                approveButton.isSelected = false
                disApproveButton.isSelected = false
                
                if let roleString =  UserDefaults.standard.value(forKey: Constant.VariableNames.roleKey) as? String{
                    if roleString == Constant.Names.EngineeringHead{
                        addBonusStackView.isHidden = false
                    }
                    else{
                        if let empIdString = UserDefaults.standard.value(forKey: Constant.VariableNames.employeeId) as? String{
                            if empIdString == "\(_attendanceDetails.empId)"{
                                addBonusStackView.isHidden = false
                            }
                            else{
                                addBonusStackView.isHidden = true
                            }
                        }
                    }
                }
                
            }
            if let roleString =  UserDefaults.standard.value(forKey: Constant.VariableNames.roleKey) as? String{
                if roleString == Constant.Names.Foreman{
                    approveStackView.isHidden = true
                    disApproveStackView.isHidden = true
                }
            }
        }
    }
    
    func callingAttendanceDetailAPI(attendanceId:String)  {
        MBProgressHUD.showAdded(to: self.view, animated: true); ObeidiModelFetchAttendance.callGetAttendanceDetailApi(requestBody:attendanceId){
            (success, result, error) in
            if success! && result != nil {
                MBProgressHUD.hide(for: self.view, animated: true)
                if let res = result as? NSDictionary{
                    self.attendanceDetails = ObeidiModelFetchAttendance.init(dictionaryDetails: res)
                    self.populateAttendanceDetails()
                }
                
            }else{
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    
    func openMapForPlace(latitude: String, longitude: String) {
        let latitude: CLLocationDegrees = Double(latitude)!//37.2
        let longitude: CLLocationDegrees = Double(longitude)!//22.9
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Place Name"
        mapItem.openInMaps(launchOptions: options)
    }
    
    @IBAction func firstLocationButtonAction(_ sender: UIButton){
        if let site = self.selectedSite{
            openMapForPlace(latitude: "\(site.latitudeNew)", longitude: "\(site.longitudeNew)")
        }
    }
    
    @IBAction func startTimeLocationButtonAction(_ sender: UIButton) {
        if let _attendanceDetails = self.attendanceDetails{
            openMapForPlace(latitude: "\(_attendanceDetails.startTimeLatitude)", longitude: "\(_attendanceDetails.startTimeLongitude)")
        }
    }
    
    @IBAction func endTimeLocationButtonAction(_ sender: UIButton) {
        if let _attendanceDetails = self.attendanceDetails{
            openMapForPlace(latitude: "\(_attendanceDetails.endTimeLatitude)", longitude: "\(_attendanceDetails.endTimeLongitude)")
        }
    }
    
    @IBAction func disApproveButtonAction(_ sender: UIButton) {
        updateAttendanceStatus.status = 0
        updateAttendanceStatusApi()
    }
    
    @IBAction func approveButtonAction(_ sender: UIButton) {
        updateAttendanceStatus.status = 1
        updateAttendanceStatusApi()
    }
    
    @IBAction func addBonusButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addBonusViewController = storyboard.instantiateViewController(withIdentifier: "AddBonusAmountVC") as! AddBonusAmountVC
        addBonusViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        addBonusViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        addBonusViewController.selectedSite = self.selectedSite
        addBonusViewController.attendanceDetails = attendanceDetails
        addBonusViewController.attendanceId = self.attendanceId
        addBonusViewController.delegate = self
        self.present(addBonusViewController, animated: true, completion: nil)
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateAttendanceStatusApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        LabourManager().callUpdateAttendanceStatusApi(with: updateAttendanceStatus.getRequestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _model = model as? ChangeAttendanceResponseModel{
                if _model.success == 1{
                    CCUtility.showDefaultAlertwithCompletionHandler(_title: Constant.AppName, _message: "Status Updated successfully", parentController: self, completion: { (status) in
                        self.dismiss(animated: true, completion: nil)
                    })
                }
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
    
    func getAddressStringfFrom(latitude:Double,longitude:Double, withCompletion completion:@escaping(Bool?,String?,Any?)->Void){
        var destinationLocation = CLLocation()
        destinationLocation = CLLocation(latitude: latitude, longitude: longitude)
        let destinationCoordinate:CLLocationCoordinate2D = destinationLocation.coordinate
        let geoCoder = GMSGeocoder()
        geoCoder.reverseGeocodeCoordinate(destinationCoordinate) { (results, error) in
            if let res = results {
                var addressString = ""
                if let addressDetails = res.firstResult() {
                    if let throughFare = addressDetails.thoroughfare {
                        addressString = addressString + throughFare
                    }
                    if let subLocality = addressDetails.subLocality {
                        if addressString.count > 0{
                            addressString = addressString + ", " + subLocality
                        }
                        else{
                            addressString = addressString + subLocality
                        }
                    }
                    if let locality = addressDetails.locality {
                        if addressString.count > 0{
                            addressString = addressString + ", " + locality
                        }
                        else{
                            addressString = addressString + locality
                        }
                    }
                    if let adArea = addressDetails.administrativeArea {
                        if addressString.count > 0{
                            addressString = addressString + ", " + adArea
                        }
                        else{
                            addressString = addressString + adArea
                        }
                    }
                    if let postalCode = addressDetails.postalCode {
                        if addressString.count > 0{
                            addressString = addressString + ", " + postalCode
                        }
                        else{
                            addressString = addressString + postalCode
                        }
                    }
                    if let country = addressDetails.country {
                        if addressString.count > 0{
                            addressString = addressString + ", " + country
                        }
                        else{
                            addressString = addressString + country
                        }
                    }
                }
                completion(true,addressString,nil)
                //self.addressTV.text = addressString
            }
            print("Ad Area:\(results?.firstResult()?.administrativeArea)")
            print("Locality:\(results?.firstResult()?.locality)")
            print("Sub locality:\(results?.firstResult()?.subLocality)")
            print("Country:\(results?.firstResult()?.country)")
            print("Through Fare:\(results?.firstResult()?.thoroughfare)")
            print("Postal Code:\(results?.firstResult()?.postalCode)")
        }
   }
}

extension CompleteEntryDetailsViewController: AddBonusAmountVCDelegate{
    func bonusAmountUpdatedDeleagte() {
        if let _attendanceId = self.attendanceId{
            callingAttendanceDetailAPI(attendanceId: "\(_attendanceId)")
        }
    }
}
