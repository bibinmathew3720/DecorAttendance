//
//  ForemanDashBoardViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 05/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ForemanDashBoardViewController: UITableViewController, DropDownDataDelegate, MyCAAnimationDelegateProtocol {
    
    weak var delegate: DashBoardDelegate?
    
    
    @IBOutlet weak var viewAttendanceStatics: UIView!
    @IBOutlet weak var viewDropDownButtons: UIView!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var viewRemainingBonus: UIView!
    @IBOutlet weak var viewPresentAbsent: UIView!
    @IBOutlet weak var pieChartViewLabourSummary: PieChartSliceView!
    
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var tableViewMonth: UITableView!
    @IBOutlet weak var tableViewDay: UITableView!
    @IBOutlet weak var tableViewSite: UITableView!
    
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
        addTapGesturesToLabels()
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
        self.lblMonth.layer.cornerRadius = 1
        self.lblMonth.layer.borderWidth = 0.5
        self.lblMonth.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        
        self.lblDay.layer.cornerRadius = 1
        self.lblDay.layer.borderWidth = 0.5
        self.lblDay.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblDay.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblMonth.textColor = ObeidiFont.Color.obeidiLightBlack()
        
        addDropDownLabelAndImage(lblToModify: lblMonth, lblText: "Dec")
        addDropDownLabelAndImage(lblToModify: lblDay, lblText: "22")
        
        
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
        
        let myString = NSMutableAttributedString(string: lblText + "      " + "      " + "                 ")
        myString.append(attachmentString)
        lblToModify.attributedText = myString
        
    }
    
    func addTapGesturesToLabels() {
        
        self.lblMonth.isUserInteractionEnabled = true
        let tapGestureMonth = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleMonthLabelTap))
        self.lblMonth.addGestureRecognizer(tapGestureMonth)
        
        self.lblDay.isUserInteractionEnabled = true
        let tapGestureDay = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleDateLabelTap))
        self.lblDay.addGestureRecognizer(tapGestureDay)
        
    }
    
    @objc func handleMonthLabelTap(){
        presentDropDownController(tableCgPoint: getPointForMonthTable(), dropDownFor: .Month, arr: fetchMonthArr())
    }
    
    @objc func handleDateLabelTap(){
        presentDropDownController(tableCgPoint: getPointForDateTable(), dropDownFor: .Date, arr: fetchDateArr())
    }
    
    func presentDropDownController(tableCgPoint: CGPoint, dropDownFor:
        DropDownNeededFor, arr: NSMutableArray) {
        for cell in tableView.visibleCells{
            
            cell.backgroundColor = ObeidiFont.Color.obeidiExactBlack()
            cell.alpha = 0.4
        }
        
        self.navigationController?.navigationBar.alpha = 0.7
        self.tabBarController?.tabBar.alpha = 0.7
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dropDownController = storyboard.instantiateViewController(withIdentifier: "DropDownViewControllerID") as! DropDownViewController
        dropDownController.tableCgPoint = tableCgPoint//CGPoint(x: self.viewDropDownButtons.frame.minX, y: self.viewDropDownButtons.frame.maxY) //+ (self.navigationController?.navigationBar.frame.size.height)!)
        dropDownController.widthTable = self.lblDay.frame.size.width
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
            dropDownController.dropDownNeededFor = dropDownFor
        }
        
        dropDownController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        dropDownController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(dropDownController, animated: true, completion: nil)
        
        
    }
    func fetchDateArr() -> NSMutableArray {
        
        let arr = NSMutableArray()
        for i in 1...31{
            
            arr.add(String(i))
            
        }
        return arr
    }
    
    func fetchMonthArr() -> NSMutableArray {
        
        var arr = NSMutableArray()
        arr = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        return arr
    }
    func fetchSiteArr() -> NSMutableArray {
        
        var arr = NSMutableArray()
        arr = ["Quatar", "Saudi", "Dubai"]
        return arr
    }
    func getPointForMonthTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblMonth.frame.minX, y: self.viewDropDownButtons.frame.maxY)
        
    }
    func getPointForDateTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblMonth.frame.size.width + self.lblMonth.frame.minX + 12, y: self.viewDropDownButtons.frame.maxY)
        
    }
    func getPointForSiteTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblMonth.frame.minX + self.lblDay.frame.size.width + self.lblMonth.frame.size.width + 24, y: self.viewDropDownButtons.frame.maxY)
        
    }
    func changedValue(is value: String!, dropDownType: DropDownNeededFor, index: Int) {
        
        switch  dropDownType {
        case .Date:
            addDropDownLabelAndImage(lblToModify: self.lblDay, lblText: value)
        case .Month:
            addDropDownLabelAndImage(lblToModify: self.lblMonth, lblText: value)
        case .Site:
            addDropDownLabelAndImage(lblToModify: self.lblSite, lblText: value)
            
        case .Attendance:
            print("  ")
        }
        
        for cell in tableView.visibleCells{
            
            cell.backgroundColor = UIColor.white
            cell.alpha = 1
        }
        
        self.navigationController?.navigationBar.alpha = 1
        self.tabBarController?.tabBar.alpha = 1
        
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
