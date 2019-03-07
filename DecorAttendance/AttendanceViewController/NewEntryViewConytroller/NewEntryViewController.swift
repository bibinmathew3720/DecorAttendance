//
//  NewEntryViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 20/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate, filterUpdatedDelegate {
    
    @IBOutlet weak var tableViewNewEntry: UITableView!
    @IBOutlet weak var viewDropDownButtons: UIView!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    
    var activeTextField: UITextField!
    var siteIdSelected: String!
    var siteModelObjArr: NSMutableArray!
    var spinner = UIActivityIndicatorView(style: .gray)
    var attendanceObjModelArr = NSMutableArray()
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = ""
        
        txtFldSearch.delegate = self
        tableViewNewEntry.delegate = self
        tableViewNewEntry.dataSource = self
        
        callGetAllSitesAPI()
        setUpViewStyles()
        addTapGesturesToLabels()
        addTapgesturesToView()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todaysDate = formatter.string(from: date)
        self.txtFldSearch.text = ""
        
        callFetchAttendanceaAPI(date: todaysDate, keyword: "", siteID: "", isAttendanceCompleted: 0)
        
        
        // Do any additional setup after loading the view.
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
        
        
        self.lblDate.layer.cornerRadius = 1
        self.lblDate.layer.borderWidth = 0.5
        self.lblDate.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblSite.layer.cornerRadius = 1
        self.lblSite.layer.borderWidth = 0.5
        self.lblSite.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
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
        
        self.lblDate.isUserInteractionEnabled = true
        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleDateLabelTap))
        self.lblDate.addGestureRecognizer(tapGestureDate)
        
        self.lblSite.isUserInteractionEnabled = true
        let tapGestureSite = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleSiteLabelTap))
        self.lblSite.addGestureRecognizer(tapGestureSite)
        
        
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
            siteViewController.filterDataArr = self.siteModelObjArr
            self.present(siteViewController, animated: true, completion: nil)
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.attendanceObjModelArr.count != 0{
            
            return self.attendanceObjModelArr.count
            
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNewEnrty", for: indexPath) as! NewEntryTableViewCell
        
        let cellData = self.attendanceObjModelArr.object(at: indexPath.row) as! ObeidiModelFetchAttendance
        
        cell.setCellContents(cellData: cellData)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 87
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "toMarkAttendanceSceneSegue:NewEnrty", sender: Any.self)
        
        
    }
    //MARK: textfield delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        let siteID: String!
        let date: String!
        siteID = ""
        if self.lblDate.text != nil{
            
            date = self.lblDate.text
        }else{
            
            date = ""
        }
        
        callFetchAttendanceaAPI(date: date, keyword: self.txtFldSearch.text!, siteID: siteID, isAttendanceCompleted: 0)
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        
    }
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
    //POPUP Delegate Methods
    func filterValueUpdated(to value: AnyObject!, updatedType: FilterTypeName!) {
        
        
        print(value.value(forKey: "name") as! String)
        switch updatedType! {
        case .site:
            print("")
            let dict = value as! NSMutableDictionary
            self.lblSite.text = (dict.value(forKey: "name") as! String)
            self.siteIdSelected = (dict.value(forKey: "id") as! String)
            
            let startDate: String!
            let endDate: String!
            if self.lblDate.text != ""{
                startDate = self.lblDate.text
                
            }else{
                startDate = ""
                
            }
            
            User.BonusDetails.bonus_budget = dict.value(forKey: "bonus_budget") as! String
            User.BonusDetails.remaining_bonus = dict.value(forKey: "remaining_bonus") as! String
            
            callFetchAttendanceaAPI(date: startDate, keyword: self.txtFldSearch.text!, siteID: self.siteIdSelected, isAttendanceCompleted: 0)
            
        default:
            print("")
        }
        
    }
    func dateUpdated(to date: String, updatedType: FilterTypeName!) {
        print(date)
        print(updatedType)
        
        switch updatedType! {
        case .endDate:
            print("nothing happened")
            //self.lblEndDate.text = date
        //self.selectedApplyDate = date
        case .startDate:
            self.lblDate.text = date
           
            let siteId: String!
            let keyword: String!
            if self.siteIdSelected != nil{
                siteId = siteIdSelected
                
            }else{
                siteId = ""
                
            }
            if self.txtFldSearch.text != "" {
                
                keyword = self.txtFldSearch.text!
            }else{
                
                keyword = ""
            }
            callFetchAttendanceaAPI(date: date, keyword: keyword, siteID: siteId, isAttendanceCompleted: 0)
        //self.selectedDate = date
        default:
            print("")
            
        }
    }
    
    func calendarColsed() {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.alpha = 1
            //self.tabBarController?.view.alpha = 0.65
            self.navigationController?.navigationBar.alpha = 1
            
            
        },completion:nil)
        
        
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
    func callFetchAttendanceaAPI(date: String, keyword: String, siteID: String, isAttendanceCompleted: Int)  {
        
        ObeidiModelFetchAttendance.callfetchAtendanceRequset(isAttendanceCompleted: isAttendanceCompleted, date: date, keyword: keyword, siteId: siteID){
            (success, result, error) in
            
            if success! && result != nil {
                
                print(result!)
                self.processFetchAttendanceAPIResponse(apiResponse: result!)
                
            }else{
                
                
                
            }
            
            
        }
        
    }
    func processFetchAttendanceAPIResponse(apiResponse: AnyObject) {

        self.attendanceObjModelArr = (apiResponse as! NSMutableArray)
        self.tableViewNewEntry.reloadData()
        
        
    }
    @IBAction func bttnActnSearch(_ sender: Any) {
        
        let siteID: String!
        let date: String!
        siteID = ""
        if self.lblDate.text != nil{
            
            date = self.lblDate.text
        }else{
            
            date = ""
        }
        
        callFetchAttendanceaAPI(date: date, keyword: self.txtFldSearch.text!, siteID: siteID, isAttendanceCompleted: 0)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMarkAttendanceSceneSegue:NewEnrty"{
            
            let vc = segue.destination as! MarkAttendanceViewController
            let model = (attendanceObjModelArr.object(at: selectedIndex) as! ObeidiModelFetchAttendance)
            let imageBase = UserDefaults.standard.value(forKey: "attendanceImageBase") as! String
            let imageUrl =  imageBase + (model.image as! String)
            let idEmployee = String(model.emp_id as! Int)
            let name = (model.name as! String)
            
            vc.imageUrlRef = imageUrl
            vc.nameRef = name
            vc.idRef = idEmployee
            vc.siteIDRef = self.siteIdSelected
            vc.siteNameRef = self.lblSite.text
            
        }
        
    }
    
}
