//
//  StaffHomeVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/17/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class StaffHomeVC: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var attendanceCountLabel: UILabel!
    var spinner = UIActivityIndicatorView(style: .gray)
    var leaveListRequest = LeavesListRequest()
    var leaveListResponse:LeavesListResponseModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
        dateLabel.text = Date().stringFromDate(format:"dd-MMMM-yyyy")
        let dateComponents = Date().getComponents()
        if let _month = dateComponents.month{
            leaveListRequest.startMonth = _month
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
                   self.populateAttendance()
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
    
    func populateAttendance(){
        if let _leaveListResponse = self.leaveListResponse{
            if _leaveListResponse.leaveMonths.count>0{
                if let _thisMonth = _leaveListResponse.leaveMonths.first{
                    attendanceCountLabel.text = "\(_thisMonth.leaveCount)"
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "staffHomeToMarkAttendance"{
            if let vc = segue.destination as? MarkAttendanceViewController{
                vc.loginUserType = .Staff
            }
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



