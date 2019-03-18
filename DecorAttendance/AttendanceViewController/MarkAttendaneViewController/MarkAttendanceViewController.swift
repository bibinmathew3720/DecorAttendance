//
//  MarkAttendanceViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 28/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit
import Kingfisher

class MarkAttendanceViewController: UIViewController, DropDownDataDelegate, filterUpdatedDelegate {
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName) {
        
    }
    
    func doneButtonActionDelegateWithSelectedDate(date: String, type: FilterTypeName) {
        
    }
    
    

    @IBOutlet weak var bttnNext: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var imageEmployee: UIImageView!
    @IBOutlet weak var lblSiteSelection: UILabel!
    @IBOutlet weak var lblAttendanceSelection: UILabel!
    
    var attendanceSelectedType: String!
    var siteModelObjArr: NSMutableArray!
    var spinner = UIActivityIndicatorView(style: .gray)
    var siteIdSelected: String!
    var idRef: String!
    var nameRef: String!
    var imageUrlRef: String!
    var attendaneTypePassRef: String!
    var siteIDRef: String!
    var siteNameRef: String!
    
    var attendanceResponse:ObeidiModelFetchAttendance?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white
        setViewStyles()
        addTapGesturesToLabels()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        setUIContents()
        callGetAllSitesAPI()
        // Do any additional setup after loading the view.
    }
    
    func setUIContents()  {
        
        self.lblID.text = idRef
        self.lblName.text = nameRef
        self.imageEmployee.kf.setImage(with: URL(string: imageUrlRef))
        self.lblSiteSelection.text = siteNameRef
        self.siteIdSelected = siteIDRef
        
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
        
        addDropDownLabelAndImage(lblToModify: lblAttendanceSelection, lblText: "Start time")
        attendanceSelectedType = (fetchAttendanceTypeArr().object(at: 0) as! String)
        addDropDownLabelAndImage(lblToModify: lblSiteSelection, lblText: "All")
        
        
    }
    
    func addDropDownLabelAndImage(lblToModify: UILabel, lblText: String) {
        
        let image = UIImage(named: "Date")
        let newSize = CGSize(width: 10, height: 10)
        
        //Resize image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image?.draw(in: CGRect(x:0, y:0, width: newSize.width, height: newSize.height))
        let imageResized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Create attachment text with image
        let attachment = NSTextAttachment()
        attachment.image = imageResized
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "  " + lblText)
        myString.append(attachmentString)
        lblToModify.attributedText = myString
        
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
                self.navigationController?.navigationBar.alpha = 0.65
                
                
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
        
//        presentDropDownController(tableCgPoint: getPointForSiteTable(), dropDownFor: .Site, arr: fetchSiteArr())
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //self.view.alpha = 0.65
                //self.tabBarController?.view.alpha = 0.65
                self.navigationController?.navigationBar.alpha = 0.65
                
                
            },completion:nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let siteViewController = storyboard.instantiateViewController(withIdentifier: "POPUPSelectorViewControllerID") as! POPUPSelectorViewController
            siteViewController.delegate = self
            //calendarViewController.isDateNeeded = true
            siteViewController.filterTypeName = FilterTypeName.site
            siteViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            siteViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            siteViewController.filterDataArr = self.siteModelObjArr
            self.present(siteViewController, animated: true, completion: nil)
            
        }
        
        
    }
    func filterValueUpdated(to value: AnyObject!, updatedType: FilterTypeName!) {
        
        switch updatedType! {
        case .site:
            print("")
            self.lblSiteSelection.text = ((value as! NSMutableDictionary).value(forKey: "name") as! String)
            self.siteIdSelected = (value.value(forKey: "id") as! String)
        case .attendanceType:
            print("")
            self.lblAttendanceSelection.text = (value as! String)
            self.attendanceSelectedType = (value as! String)
        default:
            print("")
        }
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
        arr = ["Start time", "End Time", "Sick Leave", "Absent", "Strike"]
        return arr
    }
    func fetchSiteArr() -> NSMutableArray {
        
        var arr = NSMutableArray()
        arr = ["Quatar", "Saudi", "Dubai"]
        return arr
    }
    func getPointForSiteTable() -> CGPoint{
        
        return CGPoint(x: self.lblSiteSelection.frame.minX, y:   self.lblSiteSelection.frame.maxY + self.lblSiteSelection.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)!)
        
    }
    func getPointForAttendanceTable() -> CGPoint{
        
        return CGPoint(x: self.lblAttendanceSelection.frame.minX, y: self.lblAttendanceSelection.frame.maxY + self.lblAttendanceSelection.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)!)
        
    }
    
    func changedValue(is value: String!, dropDownType: DropDownNeededFor, index: Int) {
        
        switch  dropDownType {
        case .Date:
            print("do nothing")
        case .Month:
            print("do nothing")
        case .Site:
            addDropDownLabelAndImage(lblToModify: self.lblSiteSelection, lblText: value)
        case .Attendance:
            addDropDownLabelAndImage(lblToModify: self.lblAttendanceSelection, lblText: value)
            attendanceSelectedType = value
            
        }
        
        
    }

    func callGetAllSitesAPI() {
        
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        
        ObeidiModelSites.callListSitesRequset(){
            (success, result, error) in
            
            if success! {
                
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                print(result!)
                self.siteModelObjArr = (result as! NSMutableArray)
                
                
            }else{
                
                
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                
                
            }
            
            
            
            
        }
        
        
    }
    @IBAction func bttnActnNext(_ sender: Any) {
        
        if attendanceSelectedType != nil{
            
            if attendanceSelectedType == (fetchAttendanceTypeArr().object(at: 0) as! String){
                self.attendaneTypePassRef = "start_time"
                self.performSegue(withIdentifier: "toSafetyEquipmentsSceneSegue:MarkAttendance", sender: Any.self)
                
                
            }
            else if attendanceSelectedType == (fetchAttendanceTypeArr().object(at: 1) as! String){
                self.attendaneTypePassRef = "end_time"
                self.performSegue(withIdentifier: "toCaptureImageSceneSegue:MarkAttendanceScene", sender: Any.self)
                User.Attendance.type = User.attendanceType.endTime
                
                
            }else if attendanceSelectedType == (fetchAttendanceTypeArr().object(at: 2) as! String){
                
                self.performSegue(withIdentifier: "toSickLeaveSceneSegue:MarkAttendance", sender: Any.self)
                
            }else if attendanceSelectedType == (fetchAttendanceTypeArr().object(at: 3) as! String){
                showObeidiAlert(message: "Absent has been marked", title: "Success .")
                
            }else if attendanceSelectedType == (fetchAttendanceTypeArr().object(at: 4) as! String){
                self.attendaneTypePassRef = "strike"
                showObeidiAlert(message: "Strike has been marked", title: "Success .")
                
            }
            
            
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
        if segue.identifier == "toSafetyEquipmentsSceneSegue:MarkAttendance"{
            let vc = segue.destination as! SafetyEquipmentsViewController
            
            vc.emIdRef = self.idRef
            vc.nameRef = self.nameRef
            vc.attendanceTypeRef = self.attendaneTypePassRef
            vc.siteIdRef = self.siteIdSelected
            
        }
        else if segue.identifier == "toCaptureImageSceneSegue:MarkAttendanceScene"{
            
            let vc = segue.destination as! CaptureImageViewController
            vc.dataBaseImageUrlRef = self.imageUrlRef
            vc.siteIdRef = self.siteIDRef
            vc.nameRef = self.nameRef
            vc.attendanceTypeRef = self.attendaneTypePassRef
            vc.employeeIdRef = self.idRef
            
            
            
        }
        else if segue.identifier == "toSickLeaveSceneSegue:MarkAttendance"{
            
            
            
        }
        
        
    }
    
}
