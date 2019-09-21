//
//  ReportListingVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/21/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ReportListingVC: UIViewController {
    @IBOutlet weak var reportListingTV: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var listingRequest = ReportListingRequest()
    var attendanceResponse:ObeidAttendanceResponseModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Report"
        initialisation()
        callingReportListingAPI()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
       
    }
    
    func callingReportListingAPI(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        StaffManager().getReportListingApi(with: listingRequest.getRequestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _model = model as? ObeidAttendanceResponseModel{
                if _model.error == 0{
                    self.attendanceResponse = _model
                    self.populateAttendanceList()
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
        if let _attendanceResponse = attendanceResponse{
            if _attendanceResponse.attendanceResultArray.count == 0{
                emptyView.isHidden = false
                reportListingTV.isHidden = true
            }
            else{
                emptyView.isHidden = true
                reportListingTV.isHidden = false
            }
            reportListingTV.reloadData()
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

extension ReportListingVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let attendanceRes = self.attendanceResponse{
            return attendanceRes.attendanceResultArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportListingCell", for: indexPath) as! ReportListingTVC
        if let attendanceRes = self.attendanceResponse{
            cell.setCellContents(cellData: attendanceRes.attendanceResultArray[indexPath.row])
        }
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension ReportListingVC:ReportListingTVCDelegate{
    func detailsButtonActionAt(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsController = storyboard.instantiateViewController(withIdentifier: "CompleteEntryDetailsViewControllerID") as! CompleteEntryDetailsViewController
        detailsController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        detailsController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        if let attendanceRes = self.attendanceResponse{
            detailsController.attendanceDetails =  attendanceRes.attendanceResultArray[index]
            detailsController.attendanceId = attendanceRes.attendanceResultArray[index].attendanceId
        }
        if let response = self.attendanceResponse{
            detailsController.attendanceDetails = response.attendanceResultArray[index]
        }
        //detailsController.selectedSite = self.selectedSite
        self.present(detailsController, animated: true, completion: nil)
    }
}
