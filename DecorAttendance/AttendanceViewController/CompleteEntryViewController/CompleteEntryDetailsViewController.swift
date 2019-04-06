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

    @IBOutlet weak var viewAllData: UIView!
    @IBOutlet weak var bttnApprove: UIButton!
    @IBOutlet weak var bttnDisApprove: UIButton!
    @IBOutlet weak var bttnViewMapOrignl: UIButton!
    @IBOutlet weak var bttnViewMapCaptured: UIButton!
    @IBOutlet weak var lblOrginalLctn: UILabel!
    @IBOutlet weak var lblCapturedLctn: UILabel!
    
    
    var latOrignlRef: String!
    var lngOriginlRef: String!
    var latCapturedRef: String!
    var lngCapturedRef: String!
    
    var attendanceDetails:ObeidiModelFetchAttendance?
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
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        populateAttendanceDetails()
        if let _attendanceDetails = self.attendanceDetails{
             callingAttendanceDetailAPI(attendanceId: "\(_attendanceDetails.attendanceId)")
        }
        // setViewStyles()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
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
            }
            else{
                self.statusLabel.text = "Absent"
                self.startTimeStackView.isHidden = true
                self.endTimeStackView.isHidden = true
                self.endTimeHeadingStackView.isHidden = true
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
    

    func setViewStyles() {
       
        viewAllData.dropShadow()
        
        bttnApprove.layer.cornerRadius = bttnApprove.frame.height / 2
        bttnApprove.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        
        bttnDisApprove.layer.cornerRadius = bttnDisApprove.frame.height / 2
        bttnDisApprove.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        
        bttnViewMapOrignl.layer.cornerRadius = bttnViewMapOrignl.frame.height / 2
        bttnViewMapOrignl.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        
        bttnViewMapCaptured.layer.cornerRadius = bttnViewMapCaptured.frame.height / 2
        bttnViewMapCaptured.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
    }
    
    @IBAction func bttnActnDispprove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bttnActnApprove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bttnActnViewOriginalLoctn(){
        openMapForPlace(latitude: "9.93", longitude: "76.26")
    }
    
    @IBAction func bttnActnViewCapturedLoctn(){
        openMapForPlace(latitude: "9.93", longitude: "76.26")
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
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getAddressStringfFrom(latitude:Double,longitude:Double){
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
