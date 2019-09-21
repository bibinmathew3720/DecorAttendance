//
//  ReportVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/17/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ReportVC: UIViewController {
    @IBOutlet weak var reportHeadingLabel: UILabel!
    @IBOutlet weak var reportTV: UITableView!
    
    var leaveListRequest = LeavesListRequest()
    var leaveListResponse:LeavesListResponseModel?
    var startDate:Date?
    var endDate:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
        let dateComponents = Date().getComponents()
        if let _month = dateComponents.month{
            leaveListRequest.startMonth = 1
        }
        if let _year = dateComponents.year{
            leaveListRequest.startYear = _year
        }
        if let _endMonth = dateComponents.month{
            leaveListRequest.endMonth = _endMonth
        }
        if let _endYear = dateComponents.year{
            leaveListRequest.endYear = _endYear
        }
        callingLeaveListAPI()
    }
    
    func callingLeaveListAPI(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        StaffManager().getLeavesListApi(with: leaveListRequest.getRequestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _model = model as? LeavesListResponseModel{
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
            reportHeadingLabel.text = "Attendance report (\(_leaveListResponse.leaveMonths.count))"
            self.reportTV.reloadData()
        }
    }
    
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let reportFilterVC = storyboard.instantiateViewController(withIdentifier: "ReportFilterVCID") as! ReportFilterVC
        reportFilterVC.delegate = self
        reportFilterVC.startDate = self.startDate
        reportFilterVC.endDate = self.endDate
        reportFilterVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        reportFilterVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(reportFilterVC, animated: true, completion: nil)
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

extension ReportVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _leaveListResponse = self.leaveListResponse{
            return _leaveListResponse.leaveMonths.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "staffReportTVC", for: indexPath) as! StaffReportTVC
        if let _leaveListResponse = self.leaveListResponse{
         cell.setLeaveMonth(leaveMonth:_leaveListResponse.leaveMonths[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 105
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "reportToListing", sender: Any.self)
    }
}

extension ReportVC:ReporterFilterVCDelegate{
    func okButtonActionDelegate(startDate: Date?, endDate: Date?) {
        self.startDate = startDate
        self.endDate = endDate
        recallList()
    }
    
    func recallList(){
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
        callingLeaveListAPI()
    }
}
