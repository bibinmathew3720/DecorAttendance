//
//  MedicalLeaveVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/17/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class MedicalLeaveVC: UIViewController {
    @IBOutlet weak var medicalLeavesHeadingLabel: UILabel!
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!

    @IBOutlet weak var medicalLeaveTV: UITableView!
    var leaveListRequest = LeavesListRequest()
    var leaveListResponse:MedicalLeavesResponseModel?
    var startDate:Date?
    var endDate:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        customisation()
        callingMedicalLeaveListAPI()

        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
        startDate = Date().getStartDateOfYear()
        endDate = Date()
        refreshingUI()
    }
    
    func generatingRequestParameters(){
        if let _date = startDate{
            let dateComponents = _date.getComponents()
            if let _month = dateComponents.month{
                leaveListRequest.startMonth = _month
            }
            if let _year = dateComponents.year{
                leaveListRequest.startYear = _year
            }
        }
        if let _date = endDate{
            let dateComponents = _date.getComponents()
            if let _month = dateComponents.month{
                leaveListRequest.endMonth = _month
            }
            if let _year = dateComponents.year{
                leaveListRequest.endYear = _year
            }
        }
    }
    
    func customisation(){
        startDateView.setBorderProperties()
        endDateView.setBorderProperties()
    }
    
    func callingMedicalLeaveListAPI(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        generatingRequestParameters()
        StaffManager().getMedicalLeavesListApi(with: leaveListRequest.getRequestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _model = model as? MedicalLeavesResponseModel{
                if _model.error == 0{
                    self.leaveListResponse = _model
                    self.populateAttendanceList()
                }
                else{
                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: _model.message, parentController: self)
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
    
    func populateAttendanceList(){
        if let _leaveListResponse = self.leaveListResponse{
            
            medicalLeavesHeadingLabel.text = "Medical Leaves (\(_leaveListResponse.medicalLeaves.count))"
            medicalLeaveTV.reloadData()
            if _leaveListResponse.medicalLeaves.count == 0{
               medicalLeaveTV.isHidden = true
                emptyView.isHidden = false
            }
            else{
                medicalLeaveTV.isHidden = false
                emptyView.isHidden = true
            }
        }
    }
    
    
    
    
    //MARK: Button Actions
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        showDatePicker(filterType: .startDate)
    }
    
    @IBAction func endButtonAction(_ sender: UIButton) {
        showDatePicker(filterType: .endDate)
    }
    
    func showDatePicker(filterType:FilterTypeName){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let calendarViewController = storyboard.instantiateViewController(withIdentifier: "POPUPSelectorViewControllerID") as! POPUPSelectorViewController
            calendarViewController.delegate = self
            calendarViewController.filterTypeName = filterType
            calendarViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            calendarViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(calendarViewController, animated: true, completion: nil)
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MedicalLeaveVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _leaveListResponse = self.leaveListResponse{
            return _leaveListResponse.medicalLeaves.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medicalLeaveCell", for: indexPath) as! MedicalLeaveTVC
        if let _leaveListResponse = self.leaveListResponse{
            cell.setMedicalLeave(medicalLeave:_leaveListResponse.medicalLeaves[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MedicalLeaveVC : filterUpdatedDelegate{
    func filterValueUpdated(to value: AnyObject!, updatedType: FilterTypeName!) {
        
    }
    
    func dateUpdated(to date: String, updatedType: FilterTypeName!) {
        
    }
    
    func calendarColsed() {
        
    }
    
    func doneButtonActionDelegateWithSelectedDate(date: String, type: FilterTypeName,dateInDateFormat:Date) {
        if type == .startDate{
            startDate =  dateInDateFormat
        }
        if type == .endDate{
            endDate =  dateInDateFormat
        }
        refreshingUI()
        callingMedicalLeaveListAPI()
    }
    
    func refreshingUI(){
        if let _date = startDate{
            startDateLabel.text = _date.stringFromDate(format:"yyyy/MM")
        }
        if let _date = endDate{
            endDateLabel.text = _date.stringFromDate(format:"yyyy/MM")
        }
    }
    
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName) {
        
    }
}
