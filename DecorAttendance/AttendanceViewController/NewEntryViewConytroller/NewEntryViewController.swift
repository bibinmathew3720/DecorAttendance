//
//  NewEntryViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 20/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController, UIGestureRecognizerDelegate {
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
    var selectedSite: ObeidiModelSites?
    var siteModelObjArr = [ObeidiModelSites]()
    var spinner = UIActivityIndicatorView(style: .gray)
    var selectedIndex: Int!
    let refreshControl = UIRefreshControl()
    var isFromRefreshControl = false
    @IBOutlet weak var emptyView: UIView!
    var attendanceResponseModel:ObeidAttendanceResponseModel?
    var attendanceRequest = ObeidAttendanceRequestModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = ""
        initialisation()
        txtFldSearch.delegate = self
        setUpViewStyles()
        callGetAllSitesAPI()
        addTapGesturesToLabels()
        addTapgesturesToView()
        
        attendanceRequest.startDate = CCUtility.stringFromDate(date: Date())
        self.lblDate.text = "\(CCUtility.stringFromDate(date: Date()))"
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.attendanceRequest.searchText = ""
        txtFldSearch.text = ""
        callFetchAttendanceaAPI()
    }
    
    func initialisation(){
        attendanceRequest.isAttendanceCompleteEntry = false
        self.lblDate.text = ""
        self.lblSite.text = ""
        self.title = Constant.PageNames.Attendance
        addingPulltoRefresh()
    }
    
    //MARK- Adding Refresh Control
    
    func addingPulltoRefresh(){
        refreshControl.addTarget(self,   action: #selector(refreshControlAction), for: .valueChanged)
        tableViewNewEntry.refreshControl = refreshControl
    }
    
    @objc func refreshControlAction(){
        isFromRefreshControl = true
        self.attendanceRequest.searchText = ""
        txtFldSearch.text = ""
        callFetchAttendanceaAPI()
        
    }
    
    @IBAction func searchTextFieldTextChanged(_ sender: UITextField, forEvent event: UIEvent) {
        self.attendanceRequest.searchText = sender.text ?? ""
        callFetchAttendanceaAPI()
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
//        self.dateView.isUserInteractionEnabled = true
//        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleDateLabelTap))
//        self.dateView.addGestureRecognizer(tapGestureDate)
        
        self.siteView.isUserInteractionEnabled = true
        let tapGestureSite = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleSiteLabelTap))
        self.siteView.addGestureRecognizer(tapGestureSite)
    }
    
    @objc func handleDateLabelTap(){
        
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //self.view.alpha = 0.65
                //self.tabBarController?.view.alpha = 0.65
               // self.navigationController?.navigationBar.alpha = 0.65
                
                
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
        ObeidiModelSites.callListSitesRequset(){
            (success, result, error) in
            self.isFromRefreshControl = false
            self.refreshControl.endRefreshing()
            if success! {
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                print(result!)
                if let res = result as? [ObeidiModelSites]{
                    self.siteModelObjArr = res
                    self.siteModelObjArr.remove(at: 0)
                    if self.siteModelObjArr.count>0{
                        let firstSite = self.siteModelObjArr.first
                        self.selectedSite = firstSite
                        self.attendanceRequest.siteId = firstSite?.locIdNew ?? 0
                        self.lblSite.text = firstSite?.nameNew
                        self.callFetchAttendanceaAPI()
                    }
                }
            }else{
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            }
        }
    }
   
    func callFetchAttendanceaAPI()  {
        if (!self.isFromRefreshControl){
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        ObeidiModelFetchAttendance.callfetchAtendanceRequset(requestBody: attendanceRequest.getRequestBody()){
            (success, result, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.isFromRefreshControl = false
            self.refreshControl.endRefreshing()
            if success! && result != nil {
                if let res = result as? NSDictionary{
                    self.attendanceResponseModel = ObeidAttendanceResponseModel.init(dictionaryDetails: res)
                    if let response = self.attendanceResponseModel{
                        if (response.attendanceResultArray.count == 0){
                            self.emptyView.isHidden = false
                            self.tableViewNewEntry.isHidden = true
                        }
                        else{
                            self.emptyView.isHidden = true
                            self.tableViewNewEntry.isHidden = false
                        }
                    }
                    self.tableViewNewEntry.reloadData()
                }
            }else{
            }
        }
    }
    
    @IBAction func bttnActnSearch(_ sender: Any) {
        self.view.endEditing(true)
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
                vc.selSiteModel = self.selectedSite
                vc.siteModelObjArr = self.siteModelObjArr
            }
        }
    }
    
}

extension NewEntryViewController:filterUpdatedDelegate{
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName) {
        self.attendanceRequest.siteId = selSite.locIdNew
        lblSite.text = selSite.nameNew
        self.selectedSite = selSite
        callFetchAttendanceaAPI()
    }
    
    func doneButtonActionDelegateWithSelectedDate(date: String, type: FilterTypeName,dateInDateFormat:Date) {
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selSite = self.selectedSite{
            self.selectedIndex = indexPath.row
            self.performSegue(withIdentifier: "toMarkAttendanceSceneSegue:NewEnrty", sender: Any.self)
        }
        else{
           CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "Choose a site to continue..", parentController: self)
        }
    }
}

extension NewEntryViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
