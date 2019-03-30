//
//  ForemanDashBoardViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 05/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ForemanDashBoardViewController: UITableViewController, MyCAAnimationDelegateProtocol {
    
    weak var delegate: DashBoardDelegate?
    
    
    @IBOutlet weak var viewAttendanceStatics: UIView!
    @IBOutlet weak var viewDropDownButtons: UIView!
    @IBOutlet weak var viewRemainingBonus: UIView!
    @IBOutlet weak var viewPresentAbsent: UIView!
    @IBOutlet weak var pieChartViewLabourSummary: PieChartSliceView!
    
    
    @IBOutlet weak var widthPresentColred: NSLayoutConstraint!
    @IBOutlet weak var widthPresentLight: NSLayoutConstraint!
    @IBOutlet weak var widthAbsentColored: NSLayoutConstraint!
    @IBOutlet weak var widthAbsentLight: NSLayoutConstraint!
    @IBOutlet weak var widthBonusColored: NSLayoutConstraint!
    @IBOutlet weak var widthBonusLight: NSLayoutConstraint!
    @IBOutlet weak var heightBonusIndLight: NSLayoutConstraint!
    @IBOutlet weak var bonusIndicatorLineWhite: UIView!
    @IBOutlet weak var bonusIndicatorLineColored: UIView!
    @IBOutlet weak var totalPresenceIndicatorWhite: UIView!
    @IBOutlet weak var totalPresenceIndicatorColored: UIView!
    @IBOutlet weak var totalAbsenceIndicatorWhite: UIView!
    @IBOutlet weak var totalAbsenceIndicatorColred: UIView!
    
    @IBOutlet weak var totalEmployeesLabel: UILabel!
    @IBOutlet weak var presentEmployeesLabel: UILabel!
    @IBOutlet weak var absentEmployeesLabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var siteView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    
    var window: UIWindow?
    var attendanceSummaryResponse:AttendanceSummaryResponseModel?
    var formanRequest = ForemanAttendanceRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftItemsSupplementBackButton = true
        initialisation()
        self.setUpChartViewStyles()
        setUpViewStyles()
        pieChartViewLabourSummary.myAnimationDelegate = self
        addTapGesturesToViews()
        getAttendanceSummaryApi()
        //PieChart.initializeAndPlotGraph(chartView: pieChartView, controller: self, xCoordinateArr: ["23", "45", "32"], yCoordinateArr1: ["23", "45", "32"], yCoordinateArr2: ["23", "45", "32"], yCoordinate1Label: "volume", yCoordinate2Label: "frequency")
        
        setPerformanceIndicatorLines()
        
        pieChartViewLabourSummary.slices =
            [
//                Slice(radius: 0.75, width: 0.55, isOuterCircleNeeded: false, outerCircleWidth: 0),
//                Slice(radius: 0.65, width: 0.45, isOuterCircleNeeded: false, outerCircleWidth: 0)
        ]
    }
    
    func initialisation(){
        self.dateLabel.text = CCUtility.stringFromDate(date: Date())
        self.formanRequest.attendanceDate = CCUtility.stringFromDate(date: Date())
    }
    
    //Get Attendance Summary Api
    
    func getAttendanceSummaryApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ForemanManager().getAttendanceSummary(with:formanRequest.getReqestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? AttendanceSummaryResponseModel{
                let type:StatusEnum = CCUtility.getErrorTypeFromStatusCode(errorValue: response.statusCode)
                if type == StatusEnum.success{
                    self.attendanceSummaryResponse = model
                    self.populateAttendanceSummaryResponse()
                }
                else if type == StatusEnum.sessionexpired{
                    //                    self.callRefreshTokenApi()
                }
                else{
                    CCUtility.showDefaultAlertwith(_title: User.AppName, _message: "", parentController: self)
                }
            }
            
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: User.AppName, _message: User.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: User.AppName, _message: User.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            
            print(ErrorType)
        }
    }
    
    func populateAttendanceSummaryResponse(){
        if let attendanceSummary = self.attendanceSummaryResponse{
           self.totalEmployeesLabel.text = "\(attendanceSummary.total)"
           self.presentEmployeesLabel.text = "\(attendanceSummary.presentCount)"
            self.absentEmployeesLabel.text = "\(attendanceSummary.absentCount)"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 202
        case 1:
            return 421
        case 2:
            return 110
        default:
            return 0
            
        }
    }
    
    
    @IBAction func bttnActnMenu(_ sender: Any) {
        delegate?.dashBoardDidTapedMenu(tabBarIndex: 1)
    }
    
    func setUpChartViewStyles()  {
        
        //        self.pieChartView.clipsToBounds = true
        //        self.pieChartView.layer.cornerRadius = 8.0
        //        self.pieChartView.dropShadow()
    }
    
    func setUpViewStyles() {
        self.viewPresentAbsent.layer.cornerRadius = 1
        self.viewPresentAbsent.backgroundColor = UIColor.white
        self.viewPresentAbsent.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.viewPresentAbsent.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.12).cgColor
        self.viewPresentAbsent.layer.shadowOpacity = 1
        self.viewPresentAbsent.layer.shadowRadius = 9
        
        
//        self.lblDay.textColor = ObeidiFont.Color.obeidiLightBlack()
//        self.lblMonth.textColor = ObeidiFont.Color.obeidiLightBlack()
        
        self.siteView.layer.cornerRadius = 1
        self.siteView.layer.borderWidth = 0.5
        self.siteView.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.dateView.layer.cornerRadius = 1
        self.dateView.layer.borderWidth = 0.5
        self.dateView.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.dateLabel.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.siteLabel.textColor = ObeidiFont.Color.obeidiLightBlack()
    }
    
    func addTapGesturesToViews() {
        self.dateView.isUserInteractionEnabled = true
        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(ForemanDashBoardViewController.handleDateViewTap))
        self.dateView.addGestureRecognizer(tapGestureDate)
        
        self.siteView.isUserInteractionEnabled = true
        let tapGesturSite = UITapGestureRecognizer(target: self, action: #selector(ForemanDashBoardViewController.handleSiteViewTap))
        self.siteView.addGestureRecognizer(tapGesturSite)
    }
    
    @objc func handleDateViewTap(){
        
    }
    
    @objc func handleSiteViewTap(){
       
    }
    
    func setPerformanceIndicatorLines() {
        //This is where the indicators set to their corresponding values
        ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalPresenceIndicatorWhite, lineB: totalPresenceIndicatorColored, lineAColor: ObeidiFont.Color.obeidiLineWhite(), lineBColor: ObeidiFont.Color.obeidiLineRed(), lineAValue: 1, lineBValue: 0.18, lineAMeter: widthPresentLight, lineBMeter: widthPresentColred)
        
        ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalAbsenceIndicatorWhite, lineB: totalAbsenceIndicatorColred, lineAColor: ObeidiFont.Color.obeidiLineWhite(), lineBColor: ObeidiFont.Color.obeidiLinePink(), lineAValue: 1, lineBValue: 0.98, lineAMeter: widthAbsentLight, lineBMeter: widthAbsentColored)
    }
    
    func animationDidStop(_ theAnimation: CAAnimation!, finished flag: Bool) {
        if pieChartViewLabourSummary.myAnimationDelegate != nil
        {
            pieChartViewLabourSummary.animating = false
        pieChartViewLabourSummary.myAnimationDelegate?.animationDidStop( theAnimation, finished: true)
        }
    }

}
