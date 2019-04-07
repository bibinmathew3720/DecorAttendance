//
//  CompleteEntriesViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 20/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class CompleteEntriesViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tableViewCompleteEntry: UITableView!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var lblSite: UILabel!
    
    @IBOutlet weak var siteView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    var leftButton:UIButton?
    var activeTextField: UITextField!
    var selectedSite: ObeidiModelSites?
    var siteModelObjArr = [ObeidiModelSites]()
    var completedEntriesResponseModel:ObeidAttendanceResponseModel?
    var attendanceRequest = ObeidAttendanceRequestModel()
    @IBOutlet weak var emptyView: UIView!
    var spinner = UIActivityIndicatorView(style: .gray)
    var updateAttendanceStatus = ChangeAttendanceStatusRequestModel()
    var isSuspicious:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldSearch.delegate = self
        self.navigationItem.backBarButtonItem?.title = ""
        setViewStyles()
        addTapgesturesToView()
        self.txtFldSearch.text = ""
        initialisation()
        callGetAllSitesAPI()
        addTapGesturesToLabels()
        if self.isSuspicious{
            self.title = "SUSPICIOUS ENTRIES"
            addingLeftBarButton()
            callFetchSuspiciousAttendanceAPI()
        }
        else{
            callFetchAttendanceaAPI()
        }
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
        attendanceRequest.isAttendanceCompleteEntry = true
        self.lblDate.text = ""
        self.lblSite.text = ""
    }
    
    func addingLeftBarButton(){
        self.leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.leftButton?.addTarget(self, action: #selector(leftNavButtonAction), for: .touchUpInside)
        self.leftButton?.setImage(UIImage.init(named: Constant.ImageNames.backArrow), for: UIControl.State.normal)
        var leftBarButton = UIBarButtonItem()
        leftBarButton = UIBarButtonItem.init(customView: self.leftButton!)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func leftNavButtonAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func addTapGesturesToLabels() {
        self.dateView.isUserInteractionEnabled = true
        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(CompleteEntriesViewController.handleDateLabelTap))
        self.dateView.addGestureRecognizer(tapGestureDate)
        
        self.siteView.isUserInteractionEnabled = true
        let tapGestureSite = UITapGestureRecognizer(target: self, action: #selector(CompleteEntriesViewController.handleSiteLabelTap))
        self.siteView.addGestureRecognizer(tapGestureSite)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func setViewStyles() {
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
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func addTapgesturesToView()  {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CompleteEntriesViewController.dismissKeyBoard))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    @objc func dismissKeyBoard()  {
        if activeTextField != nil{
            activeTextField.resignFirstResponder()
        }
    }
    
    @objc func handleDateLabelTap(){
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
            calendarViewController.filterTypeName = FilterTypeName.endDate
            calendarViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            calendarViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(calendarViewController, animated: true, completion: nil)
            
        }
        
    }
    @objc func handleSiteLabelTap(){
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //self.view.alpha = 0.65
                //self.tabBarController?.view.alpha = 0.65
                //self.navigationController?.navigationBar.alpha = 0.65
                
                
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
    
    func callGetAllSitesAPI() {
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        ObeidiModelSites.callListSitesRequset(){
            (success, result, error) in
            if success! {
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                print(result!)
                if let res = result as? [ObeidiModelSites]{
                    self.siteModelObjArr = res
                    self.siteModelObjArr.remove(at: 0)
                }
            }else{
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            }
        }
    }
    
    func callFetchAttendanceaAPI()  { ObeidiModelFetchAttendance.callfetchAtendanceRequset(requestBody:attendanceRequest.getRequestBody()){
            (success, result, error) in
            if success! && result != nil {
                if let res = result as? NSDictionary{
                    self.completedEntriesResponseModel = ObeidAttendanceResponseModel.init(dictionaryDetails: res)
                    if let response = self.completedEntriesResponseModel{
                        if (response.attendanceResultArray.count == 0){
                            self.emptyView.isHidden = false
                            self.tableViewCompleteEntry.isHidden = true
                        }
                        else{
                            self.emptyView.isHidden = true
                            self.tableViewCompleteEntry.isHidden = false
                        }
                    }
                    self.tableViewCompleteEntry.reloadData()
                }
                
            }else{
            }
        }
    }
    
    @IBAction func bttnActnSearch(_ sender: Any) {
        self.view.endEditing(true)
        if let searchText = txtFldSearch.text{
            attendanceRequest.searchText = searchText
        }
        callFetchAttendanceaAPI()
    }
    
}

extension CompleteEntriesViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let attendanceRes = self.completedEntriesResponseModel{
            return attendanceRes.attendanceResultArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCompleteEntry", for: indexPath) as! CompleteEntryTableViewCell
        if let attendanceRes = self.completedEntriesResponseModel{
            cell.setCellContents(cellData: attendanceRes.attendanceResultArray[indexPath.row])
        }
        cell.tag = indexPath.row
        cell.delegate = self
        cell.parentViewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension CompleteEntriesViewController:filterUpdatedDelegate{
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName) {
        self.attendanceRequest.siteId = selSite.locIdNew
        lblSite.text = selSite.nameNew
        self.selectedSite = selSite
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

extension CompleteEntriesViewController:CompltedEntryCellDelegate{
    func viewDetailsButtonActionAt(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsController = storyboard.instantiateViewController(withIdentifier: "CompleteEntryDetailsViewControllerID") as! CompleteEntryDetailsViewController
        detailsController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        detailsController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        if let attendanceRes = self.completedEntriesResponseModel{
            detailsController.attendanceDetails =  attendanceRes.attendanceResultArray[index]
        }
        if let response = self.completedEntriesResponseModel{
            detailsController.attendanceDetails = response.attendanceResultArray[index]
        }
        self.present(detailsController, animated: true, completion: nil)
    }
    
    func approveButtonActionAt(index: Int) {
        updateAttendanceStatus.status = 1
        if let attendanceRes = self.completedEntriesResponseModel{
            updateAttendanceStatus.attendanceId =  attendanceRes.attendanceResultArray[index].attendanceId
        }
        updateAttendanceStatusApi()
    }
    
    func disApproveButtonActionAt(index: Int) {
        updateAttendanceStatus.status = 0
        if let attendanceRes = self.completedEntriesResponseModel{
            updateAttendanceStatus.attendanceId =  attendanceRes.attendanceResultArray[index].attendanceId
        }
        updateAttendanceStatusApi()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constant.SegueIdentifiers.AttendanceCompletedListToDetail ){
           
        }
    }
    
    func updateAttendanceStatusApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        LabourManager().callUpdateAttendanceStatusApi(with: updateAttendanceStatus.getRequestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _model = model as? ChangeAttendanceResponseModel{
                if _model.success == 1{
                    self.callFetchAttendanceaAPI()
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
    
    //MARK - Suspicious Attendance Api
    
    func callFetchSuspiciousAttendanceAPI()  {
        attendanceRequest.isSuspicious = true
        ObeidiModelFetchAttendance.callfetchAtendanceRequset(requestBody:attendanceRequest.getRequestBody()){
        (success, result, error) in
        if success! && result != nil {
            if let res = result as? NSDictionary{
                self.completedEntriesResponseModel = ObeidAttendanceResponseModel.init(dictionaryDetails: res)
                if let response = self.completedEntriesResponseModel{
                    if (response.attendanceResultArray.count == 0){
                        self.emptyView.isHidden = false
                        self.tableViewCompleteEntry.isHidden = true
                    }
                    else{
                        self.emptyView.isHidden = true
                        self.tableViewCompleteEntry.isHidden = false
                    }
                }
                self.tableViewCompleteEntry.reloadData()
            }
            
        }else{
        }
        }
    }
    
}
