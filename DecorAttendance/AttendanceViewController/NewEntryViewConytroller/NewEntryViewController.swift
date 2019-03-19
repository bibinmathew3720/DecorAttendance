//
//  NewEntryViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 20/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var tableViewNewEntry: UITableView!
    @IBOutlet weak var viewDropDownButtons: UIView!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var siteView: UIView!
    
    var activeTextField: UITextField!
    var siteIdSelected: String!
    var siteModelObjArr = [ObeidiModelSites]()
    var spinner = UIActivityIndicatorView(style: .gray)
    var selectedIndex: Int!
    
    var attendanceResponseModel:ObeidAttendanceResponseModel?
    var attendanceRequest = ObeidAttendanceRequestModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = ""
        initialisation()
        txtFldSearch.delegate = self
        callGetAllSitesAPI()
        setUpViewStyles()
        addTapGesturesToLabels()
        addTapgesturesToView()
        callFetchAttendanceaAPI()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
        attendanceRequest.isAttendanceCompleteEntry = false
        self.lblDate.text = ""
        self.lblSite.text = ""
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: tableViewNewEntry))!{
            return false
        }
        return true
    }
    
    func setUpViewStyles() {
        let layer = self.viewSearchBar!
        layer.backgroundColor = UIColor.white
        layer.layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.2).cgColor
        layer.layer.shadowOpacity = 1
        layer.layer.shadowRadius = 8
        
        let layer1 = txtFldSearch!
        layer1.layer.cornerRadius = 3
        layer1.layer.borderWidth = 0.5
        layer1.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        
        self.siteView.layer.cornerRadius = 1
        self.siteView.layer.borderWidth = 0.5
        self.siteView.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.dateView.layer.cornerRadius = 1
        self.dateView.layer.borderWidth = 0.5
        self.dateView.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblDate.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblSite.textColor = ObeidiFont.Color.obeidiLightBlack()
    }
    
    func addDropDownLabelAndImage(lblToModify: UILabel, lblText: String) {
        
        let image = UIImage(named: "dropdown")
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
        
        self.dateView.isUserInteractionEnabled = true
        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleDateLabelTap))
        self.dateView.addGestureRecognizer(tapGestureDate)
        
        self.siteView.isUserInteractionEnabled = true
        let tapGestureSite = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleSiteLabelTap))
        self.siteView.addGestureRecognizer(tapGestureSite)
        
        
    }
    @objc func handleDateLabelTap(){
        
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
            calendarViewController.filterTypeName = FilterTypeName.startDate
            calendarViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            calendarViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(calendarViewController, animated: true, completion: nil)
            
        }
        
    }
    @objc func handleSiteLabelTap(){
        
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.view.alpha = 0.65
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
            siteViewController.sitesArray = self.siteModelObjArr
            self.present(siteViewController, animated: true, completion: nil)
            
        }
    }
    
    //MARK: textfield delegate methods
    
    func addTapgesturesToView()  {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewEntryViewController.dismissKeyBoard))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyBoard()  {
        if activeTextField != nil{
            activeTextField.resignFirstResponder()
        }
    }

    
   
    func callGetAllSitesAPI() {
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        ObeidiModelSites.callListSitesRequset(){
            (success, result, error) in
            if success! {
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                print(result!)
                if let res = result as? [ObeidiModelSites]{
                    self.siteModelObjArr = res
                }
            }else{
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            }
        }
    }
    
    func callFetchAttendanceaAPI()  {
        ObeidiModelFetchAttendance.callfetchAtendanceRequset(requestBody: attendanceRequest.getRequestBody()){
            (success, result, error) in
            if success! && result != nil {
                if let res = result as? NSDictionary{
                    self.attendanceResponseModel = ObeidAttendanceResponseModel.init(dictionaryDetails: res)
                    self.tableViewNewEntry.reloadData()
                }
            }else{
            }
        }
    }
    
    @IBAction func bttnActnSearch(_ sender: Any) {
        if let searchText = self.txtFldSearch.text{
            self.attendanceRequest.searchText = searchText
            callFetchAttendanceaAPI()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMarkAttendanceSceneSegue:NewEnrty"{
            let vc = segue.destination as! MarkAttendanceViewController
            if let attendanceRes = self.attendanceResponseModel{
                vc.attendanceResponse = attendanceRes.attendanceResultArray[self.selectedIndex]
                vc.siteModelObjArr = self.siteModelObjArr
            }
        }
    }
    
}

extension NewEntryViewController:filterUpdatedDelegate{
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName) {
        self.attendanceRequest.siteId = selSite.locIdNew
        lblSite.text = selSite.nameNew
        callFetchAttendanceaAPI()
    }
    
    func doneButtonActionDelegateWithSelectedDate(date: String, type: FilterTypeName) {
        self.attendanceRequest.startDate = date
        lblDate.text = date
        callFetchAttendanceaAPI()
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

extension NewEntryViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let attendanceRes = self.attendanceResponseModel{
            return attendanceRes.attendanceResultArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNewEnrty", for: indexPath) as! NewEntryTableViewCell
        if let attendanceRes = self.attendanceResponseModel{
            cell.setCellContents(cellData: attendanceRes.attendanceResultArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 87
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "toMarkAttendanceSceneSegue:NewEnrty", sender: Any.self)
    }
}
