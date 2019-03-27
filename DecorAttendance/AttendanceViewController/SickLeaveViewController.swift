//
//  SickLeaveViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 20/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class SickLeaveViewController: UIViewController,dismissDelegate {

    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var bttnTakePicture: UIButton!
    @IBOutlet weak var bttnUploadPicture: UIButton!
    @IBOutlet weak var bttnNext: UIButton!
    
    @IBOutlet weak var selImageView: UIImageView!
    var spinner = UIActivityIndicatorView(style: .gray)
    
    var startDate:String?
    var endDate:String?
    var selSiteModel:ObeidiModelSites?
    var attendanceType:AttendanceType?
    var selLocation:Location?
    var selImage:UIImage?
    var imageData:Data?
     var attendanceResponse:ObeidiModelFetchAttendance?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = Constant.PageNames.Attendance
        setViewStyles()
        addTapGesturesToLabels()
        populateData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bttnActnNext(_ sender
        : Any){
        if isValid(){
            callPostAttendanceAPI()
        }
    }
    
    func isValid()->Bool{
        var valid = true
        if let _selImage = self.selImage{
            if let _endDate = self.endDate{
                
            }
            else{
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "Please select End Date", parentController: self)
                valid = false
            }
        }
        else{
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "Please add image", parentController: self)
            valid = false
        }
        return valid
    }

    @IBAction func bttnActnTakePicture(_ sender
        : Any){
        self.performSegue(withIdentifier: "toCaptureSceneSegue:SickLeave", sender: Any.self)
    }
    
    @IBAction func bttnActnAttachPicture(_ sender
        : Any){
         addingImagePickerController(sourceType: .photoLibrary)
    }
    
    func setViewStyles() {
        let bttnDone = self.bttnNext!
        bttnDone.layer.cornerRadius = self.bttnNext.frame.size.height / 2
        bttnDone.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        bttnDone.layer.shadowOffset = CGSize(width: 0, height: 8)
        bttnDone.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        bttnDone.layer.shadowOpacity = 1
        bttnDone.layer.shadowRadius = self.bttnNext.frame.size.height / 2
        
        self.lblEndDate.layer.cornerRadius = 1
        self.lblEndDate.layer.borderWidth = 0.5
        self.lblEndDate.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblStartDate.layer.cornerRadius = 1
        self.lblStartDate.layer.borderWidth = 0.5
        self.lblStartDate.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        
        bttnTakePicture.layer.cornerRadius = 16
        bttnTakePicture.layer.borderWidth = 1
        bttnTakePicture.layer.borderColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1).cgColor
        bttnUploadPicture.layer.cornerRadius = 16
        bttnUploadPicture.layer.borderWidth = 1
        bttnUploadPicture.layer.borderColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1).cgColor
    }
    
    func populateData(){
        startDate = CCUtility.stringFromDate(date: Date())
        self.lblStartDate.text = "\(CCUtility.stringFromDate(date: Date()))"
    }
    
    //MARK:Tap Gestures
    
    func addTapGesturesToLabels() {
//        self.lblStartDate.isUserInteractionEnabled = true
//        let tapGestureStart = UITapGestureRecognizer(target: self, action: #selector(SickLeaveViewController.handleStartDateLabelTap))
//        self.lblStartDate.addGestureRecognizer(tapGestureStart)
    
        self.lblEndDate.isUserInteractionEnabled = true
        let tapGestureEnd = UITapGestureRecognizer(target: self, action: #selector(SickLeaveViewController.handleEndDateLabelTap))
        self.lblEndDate.addGestureRecognizer(tapGestureEnd)
        
    }
    @objc func handleStartDateLabelTap(){
        
        //presentDropDownController(tableCgPoint: getPointForMonthTable(), dropDownFor: .Month, arr: fetchMonthArr())
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //self.view.alpha = 0.65
                //self.tabBarController?.view.alpha = 0.65
                //self.navigationController?.navigationBar.alpha = 0.65
                
            },completion:nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let calendarViewController = storyboard.instantiateViewController(withIdentifier: "POPUPSelectorViewControllerID") as! POPUPSelectorViewController
            calendarViewController.delegate = self
            //calendarViewController.isDateNeeded = true
            calendarViewController.filterTypeName = FilterTypeName.startDate
            calendarViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            calendarViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(calendarViewController, animated: true, completion: nil)
            
        }
        
    }
    @objc func handleEndDateLabelTap(){
        
        //presentDropDownController(tableCgPoint: getPointForMonthTable(), dropDownFor: .Month, arr: fetchMonthArr())
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.view.alpha = 0.65
                //self.tabBarController?.view.alpha = 0.65
                self.navigationController?.navigationBar.alpha = 0.65
                
                
            },completion:nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let calendarViewController = storyboard.instantiateViewController(withIdentifier: "POPUPSelectorViewControllerID") as! POPUPSelectorViewController
            calendarViewController.delegate = self
            //calendarViewController.isDateNeeded = true
            calendarViewController.filterTypeName = FilterTypeName.endDate
            calendarViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            calendarViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(calendarViewController, animated: true, completion: nil)
            
        }
        
    }
    
    func showObeidiAlert(message: String, title: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let alertController = storyboard.instantiateViewController(withIdentifier: "ObeidiAlertViewControllerID") as! ObeidiAlertViewController
        
        alertController.titleRef = title
        alertController.explanationRef = message
        alertController.parentController = self
        
        alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCaptureSceneSegue:SickLeave"{
            let vc = segue.destination as! CaptureImageViewController
            vc.attendanceType = AttendanceType.SickLeave
            vc.delegate = self
        }
    }
    
    func addingImagePickerController(sourceType:UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType;
        present(imagePicker, animated: true, completion: nil)
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
                alertController.explanationRef = "Your Sick leave has been marked. "
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
        let paramsDict = NSMutableDictionary()
        paramsDict.setValue("0", forKey: "penalty")
        if let siteModel = self.selSiteModel{
            paramsDict.setValue("\(siteModel.locIdNew)", forKey: "site_id")
        }
        if let location = self.selLocation{
            paramsDict.setValue("\(location.latitude)", forKey: "lat")
            paramsDict.setValue("\(location.longitude)", forKey: "lng")
        }
        if let attType = self.attendanceType{
            paramsDict.setValue(CCUtility.getAttendanceTypeString(attendanceType:attType), forKey: "type")
        }
        if let attResponse = self.attendanceResponse{
            paramsDict.setValue("\(attResponse.empId)", forKey: "emp_id")
        }
        paramsDict.setValue("0", forKey: "bonus")
        if let _image = self.selImage{
            paramsDict.setValue(_image, forKey: "image")
        }
        if let _startDate = self.startDate{
           paramsDict.setValue(_startDate, forKey: "leave_start_date")
        }
        if let _startDate = self.endDate{
            paramsDict.setValue(_startDate, forKey: "leave_end_date")
        }
        return paramsDict
    }
    
    func dismissed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension SickLeaveViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
           selImageView.image = image
           self.selImage = image
            self.imageData = image.jpegData(compressionQuality: 1.0)
        } else{
            print("Something went wrong in  image")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension SickLeaveViewController:filterUpdatedDelegate{
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName) {
        
    }
    
    func doneButtonActionDelegateWithSelectedDate(date: String, type: FilterTypeName) {
        if type == FilterTypeName.endDate{
            self.endDate = date
            self.lblEndDate.text = "\(date)"
        }
    }
    
    func filterValueUpdated(to value: AnyObject!, updatedType: FilterTypeName!) {
    }
    
    func dateUpdated(to date: String, updatedType: FilterTypeName!) {
        
    }
    
    func calendarColsed() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.alpha = 1
            //self.tabBarController?.view.alpha = 0.65
            self.navigationController?.navigationBar.alpha = 1
        },completion:nil)
    }
}

extension SickLeaveViewController:CaptureImageViewControllerDelegate{
    func capturedImage(image: UIImage, imageData: Data) {
        selImageView.image = image
        self.selImage = image
        self.imageData = imageData
    }
}
