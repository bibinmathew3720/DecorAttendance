//
//  DashBoardViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 16/12/18.
//  Copyright © 2018 Sreeith n  kRemaining bonusrishna. All rights reserved.
//

import UIKit


protocol DashBoardDelegate: class {
    
    func dashBoardDidTapedMenu(tabBarIndex: Int)
    
}

class DashBoardViewController: UITableViewController, DropDownDataDelegate, MyCAAnimationDelegateProtocol, filterUpdatedDelegate {
    
    weak var delegate: DashBoardDelegate?
    
    @IBOutlet weak var lblRemainingBnsAmnt: UILabel!
    @IBOutlet weak var lblRemainingBnsPerc: UILabel!
    @IBOutlet weak var lblTotalBnsAmnt: UILabel!
    @IBOutlet weak var lblTotalBnsPerc: UILabel!
    @IBOutlet weak var lblTotalOTAmnt: UILabel!
    @IBOutlet weak var lblTotalOTPerc: UILabel!
    @IBOutlet weak var lblTotalCostAmnt: UILabel!
    
    @IBOutlet weak var viewDropDownButtons: UIView!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var viewRemainingBonus: UIView!
    @IBOutlet weak var viewTotalOtBonus: UIView!
    @IBOutlet weak var pieChartViewCostSummary: PieChartSliceView!
    
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStratDate: UILabel!
    @IBOutlet weak var tableViewMonth: UITableView!
    @IBOutlet weak var tableViewDay: UITableView!
    @IBOutlet weak var tableViewSite: UITableView!
    
    @IBOutlet weak var widthTotalBounsColred: NSLayoutConstraint!
    @IBOutlet weak var widthTotalBonusLight: NSLayoutConstraint!
    @IBOutlet weak var widthTotalOTColored: NSLayoutConstraint!
    @IBOutlet weak var widthTotalOTLight: NSLayoutConstraint!
    @IBOutlet weak var widthBonusColored: NSLayoutConstraint!
    @IBOutlet weak var widthBonusLight: NSLayoutConstraint!
    @IBOutlet weak var widthSickLeaveColoured: NSLayoutConstraint!
    @IBOutlet weak var widthSickLeaveWhite: NSLayoutConstraint!
    @IBOutlet weak var widthVacationColoured: NSLayoutConstraint!
    @IBOutlet weak var widthVacationWhite: NSLayoutConstraint!
    @IBOutlet weak var widthWageColoured: NSLayoutConstraint!
    @IBOutlet weak var widthWageWhite: NSLayoutConstraint!
    
    @IBOutlet weak var heightBonusIndLight: NSLayoutConstraint!
    @IBOutlet weak var bonusIndicatorLineWhite: UIView!
    @IBOutlet weak var bonusIndicatorLineColored: UIView!
    @IBOutlet weak var totalBonusIndicatorWhite: UIView!
    @IBOutlet weak var totalBonusIndicatorColored: UIView!
    @IBOutlet weak var totalOTIndicatorWhite: UIView!
    @IBOutlet weak var totalOTIndicatorColred: UIView!
    @IBOutlet weak var totalPaidVacationIndctrWhite: UIView!
    @IBOutlet weak var totalPaidVacationIndctrColoured: UIView!
    @IBOutlet weak var totalSickLeaveIndctrWhite: UIView!
    @IBOutlet weak var totalSickLeaveIndctrColoured: UIView!
    @IBOutlet weak var totaltotalWageIndctrWhite: UIView!
    @IBOutlet weak var totalWageIndctrColoured: UIView!
   
    @IBOutlet weak var lblPaidVacationPer: UILabel!
    
    @IBOutlet weak var lblWageAmnt: UILabel!
    @IBOutlet weak var lblVacationAmnt: UILabel!
    
    @IBOutlet weak var lblWagePer: UILabel!
    @IBOutlet weak var lblLeavePer: UILabel!
    @IBOutlet weak var lblLeaveAmnt: UILabel!
    
    
    
    var window: UIWindow?
    var sitesArr: NSMutableArray!
    var spinner = UIActivityIndicatorView(style: .gray)
    var siteModelObjArr: NSMutableArray!
    var siteSelectedIndex: Int!
    var daySelectedIndex: Int!
    var monthSelectedIndex: Int!
    var siteIdSelected: String!
    var costSummaryModel: ObeidiModelCostSummarySiteWise!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.navigationItem.leftItemsSupplementBackButton = true
        
        self.setUpChartViewStyles()
        setUpViewStyles()
        pieChartViewCostSummary.myAnimationDelegate = self
        callGetAllSitesAPI()
        addTapGesturesToLabels()
        //PieChart.initializeAndPlotGraph(chartView: pieChartView, controller: self, xCoordinateArr: ["23", "45", "32"], yCoordinateArr1: ["23", "45", "32"], yCoordinateArr2: ["23", "45", "32"], yCoordinate1Label: "volume", yCoordinate2Label: "frequency")
        
        //setPerformanceIndicatorLines()
        
        //pieChartViewCostSummary.style = [Style(isOuterCircleNeeded: true)]
//        pieChartViewCostSummary.slices =
//            [
//                Slice(radius: 0.75, width: 0.55),
//                Slice(radius: 0.65, width: 0.45)
//        ]
        
        
        
        //-----------here ---------//
//        pieChartViewCostSummary.slices = [
//
//            Slice(radius: 0.75, width: 0.55, isOuterCircleNeeded: true, outerCircleWidth: 0.70),
//            Slice(radius: 0.65, width: 0.45, isOuterCircleNeeded: true, outerCircleWidth: 0.70)
//
//        ]
        callSiteWiseCostSummaryAPI(siteID: "All", startDate: "All", endDate: "All")
        
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
            return 82
        case 1:
            return 421
        case 2:
            return 277
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
        
        self.viewRemainingBonus.layer.cornerRadius = 1
        self.viewRemainingBonus.backgroundColor = UIColor.white
        self.viewRemainingBonus.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.viewRemainingBonus.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.12).cgColor
        self.viewRemainingBonus.layer.shadowOpacity = 1
        self.viewRemainingBonus.layer.shadowRadius = 9
        
        
        self.viewTotalOtBonus.layer.cornerRadius = 1
        self.viewTotalOtBonus.backgroundColor = UIColor.white
        self.viewTotalOtBonus.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.viewTotalOtBonus.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.12).cgColor
        self.viewTotalOtBonus.layer.shadowOpacity = 1
        self.viewTotalOtBonus.layer.shadowRadius = 9
        
        
        self.lblStratDate.layer.cornerRadius = 1
        self.lblStratDate.layer.borderWidth = 0.5
        self.lblStratDate.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblSite.layer.cornerRadius = 1
        self.lblSite.layer.borderWidth = 0.5
        self.lblSite.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblEndDate.layer.cornerRadius = 1
        self.lblEndDate.layer.borderWidth = 0.5
        self.lblEndDate.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblEndDate.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblStratDate.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblSite.textColor = ObeidiFont.Color.obeidiLightBlack()
        
        addDropDownLabelAndImage(lblToModify: lblStratDate, lblText: "ALL")
        addDropDownLabelAndImage(lblToModify: lblSite, lblText: "ALL")
        addDropDownLabelAndImage(lblToModify: lblEndDate, lblText: "ALL")
        
        
    }
    
    func addDropDownLabelAndImage(lblToModify: UILabel, lblText: String) {
//        var image: UIImage!
//        if lblToModify != self.lblSite {
//            image = UIImage(named: "attendsnce_fill")
//
//        }else{
//           image = UIImage(named: "dropdown")
//
//        }
//
//        let newSize = CGSize(width: 10, height: 10)
//
//        //Resize image
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//        image?.draw(in: CGRect(x:0, y:0, width: newSize.width, height: newSize.height))
//        let imageResized = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        //Create attachment text with image
//        let attachment = NSTextAttachment()
//        attachment.image = imageResized
//        let attachmentString = NSAttributedString(attachment: attachment)
//
//        let myString = NSMutableAttributedString(string: lblText)
//        myString.append(attachmentString)
//        lblToModify.attributedText = myString
        
        lblToModify.text = lblText
        
    }
    
    func addTapGesturesToLabels() {
        
        self.lblStratDate.isUserInteractionEnabled = true
        let tapGestureMonth = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleMonthLabelTap))
        self.lblStratDate.addGestureRecognizer(tapGestureMonth)
        
        self.lblSite.isUserInteractionEnabled = true
        let tapGestureSite = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleSiteLabelTap))
        self.lblSite.addGestureRecognizer(tapGestureSite)
        
        self.lblEndDate.isUserInteractionEnabled = true
        let tapGestureDay = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleDateLabelTap))
        self.lblEndDate.addGestureRecognizer(tapGestureDay)
        
    }
    @objc func handleMonthLabelTap(){
        
        //presentDropDownController(tableCgPoint: getPointForMonthTable(), dropDownFor: .Month, arr: fetchMonthArr())
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
    @objc func handleDateLabelTap(){
        
        //presentDropDownController(tableCgPoint: getPointForDateTable(), dropDownFor: .Date, arr: fetchDateArr())
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
            calendarViewController.filterTypeName = FilterTypeName.endDate
            calendarViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            calendarViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(calendarViewController, animated: true, completion: nil)
            
        }
        
    }
    @objc func handleSiteLabelTap(){
        
        //presentDropDownController(tableCgPoint: getPointForSiteTable(), dropDownFor: .Site, arr: fetchSiteArr())
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
        dropDownController.widthTable = self.lblEndDate.frame.size.width
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
        
        let arr = NSMutableArray()
        //arr = ["Quatar", "Saudi", "Dubai"]
        for case let item as ObeidiModelSites in self.siteModelObjArr{
            
            arr.add(item.name as! String)
            
        }
        return arr
    }
    func getPointForMonthTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblStratDate.frame.minX, y: self.viewDropDownButtons.frame.maxY + 90)
        
    }
    func getPointForDateTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblStratDate.frame.size.width + self.lblStratDate.frame.minX + 12, y: self.viewDropDownButtons.frame.maxY + 90)
        
    }
    func getPointForSiteTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblStratDate.frame.minX + self.lblEndDate.frame.size.width + self.lblStratDate.frame.size.width + 24, y: self.viewDropDownButtons.frame.maxY + 90)
        
    }
    func changedValue(is value: String!, dropDownType: DropDownNeededFor, index: Int) {
        
        switch  dropDownType {
        case .Date:
            addDropDownLabelAndImage(lblToModify: self.lblEndDate, lblText: value)
            daySelectedIndex = index
        case .Month:
            addDropDownLabelAndImage(lblToModify: self.lblStratDate, lblText: value)
            monthSelectedIndex = index
        case .Site:
            addDropDownLabelAndImage(lblToModify: self.lblSite, lblText: value)
            self.siteSelectedIndex = index
            
            let monthValue = String(monthSelectedIndex + 1)
            let dayValue = String(daySelectedIndex + 1)
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            let formattedDate = formatter.string(from: date) + "-" + monthValue + "-" + dayValue
            
            let siteID = String((self.siteModelObjArr.object(at: siteSelectedIndex) as! ObeidiModelSites).id as! Int)
            
            callSiteWiseCostSummaryAPI(siteID: siteID, startDate: "", endDate: formattedDate)
            
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
    
    func animationDidStop(_ theAnimation: CAAnimation!, finished flag: Bool) {
    
//        if pieChartViewCostSummary.myAnimationDelegate != nil
//        {
//            pieChartViewCostSummary.animating = false
//            pieChartViewCostSummary.myAnimationDelegate?.animationDidStop( theAnimation, finished: true)
//        }
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
    func callSiteWiseCostSummaryAPI(siteID: String!, startDate: String!, endDate: String!)  {
        
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        ObeidiModelCostSummarySiteWise.callCostSummaryRequset(siteId: siteID, startDate: startDate, endDate: endDate) {
            (success, result, error) in
            
            
            if success! {
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                self.processSiteWiseCostSummaryResponse(apiResponse: result! as! ObeidiModelCostSummarySiteWise)
                
                print(result!)
            }else{
                
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                
            }
            
            
        }
        
    }
    func processSiteWiseCostSummaryResponse(apiResponse: ObeidiModelCostSummarySiteWise) {
        
        drawChartAndPerformanceIndicators(modelObj: apiResponse)
        
        
    }
    func drawChartAndPerformanceIndicators(modelObj: ObeidiModelCostSummarySiteWise){
        
        self.costSummaryModel = modelObj
        if let costSummary = self.costSummaryModel{
            self.lblRemainingBnsAmnt.text = "AED " + String.init(format: "%0.2f", costSummary.remainingBonusAmountNew)
            self.lblTotalOTAmnt.text = "AED " + String.init(format: "%0.2f", costSummary.overTimeAmountNew)
            self.lblTotalBnsAmnt.text = "AED " + String.init(format: "%0.2f", costSummary.bonusAmountNew)
            self.lblWageAmnt.text = "AED " + String.init(format: "%0.2f", costSummary.netWageAmountNew)
            self.lblLeaveAmnt.text = "AED " + String.init(format: "%0.2f", costSummary.medicalLeaveAmountNew)
            self.lblVacationAmnt.text = "AED " + String.init(format: "%0.2f", costSummary.paidVacationAmountNew)
             self.lblTotalCostAmnt.text = "AED " + String.init(format: "%0.2f", costSummary.totalAmountNew)
            
            self.lblRemainingBnsPerc.text = String(format: "%0.02f", costSummary.remainingBonusPercentage) + "%"
            self.lblRemainingBnsPerc.textColor = Constant.Colors.remainingBonusColor
             ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.bonusIndicatorLineWhite, lineB: bonusIndicatorLineColored, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.remainingBonusColor, lineAValue: 1, lineBValue: (costSummary.remainingBonusPercentage/100.00), lineAMeter: widthBonusLight, lineBMeter: widthBonusColored)
            
            self.lblTotalOTPerc.text = String(format: "%0.02f", costSummary.overTimePercentage) + "%"
            self.lblTotalOTPerc.textColor = Constant.Colors.overTimeColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalOTIndicatorWhite, lineB: totalOTIndicatorColred, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.overTimeColor, lineAValue: 1, lineBValue: (costSummary.overTimePercentage/100.00), lineAMeter: widthTotalOTLight, lineBMeter: widthTotalOTColored)
            
            self.lblTotalBnsPerc.text = String(format: "%0.02f", costSummary.bonusPercentage) + "%"
            self.lblTotalBnsPerc.textColor = Constant.Colors.bonusColor
            self.lblTotalBnsPerc.textColor = Constant.Colors.bonusColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalBonusIndicatorWhite, lineB: totalBonusIndicatorColored, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.bonusColor, lineAValue: 1, lineBValue: (costSummary.bonusPercentage/100.00), lineAMeter: widthTotalBonusLight, lineBMeter: widthTotalBounsColred)
            
            self.lblWagePer.text = String(format: "%0.02f", costSummary.wagePercentage) + "%"
            self.lblWagePer.textColor = Constant.Colors.wageColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totaltotalWageIndctrWhite, lineB: totalWageIndctrColoured, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.wageColor, lineAValue: 1, lineBValue: (costSummary.wagePercentage/100.00), lineAMeter: widthWageWhite, lineBMeter: widthWageColoured)
            
            self.lblLeavePer.text = String(format: "%0.02f", costSummary.sickLeavePercentage) + "%"
            self.lblLeavePer.textColor = Constant.Colors.sickLeaveColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalSickLeaveIndctrWhite, lineB: totalSickLeaveIndctrColoured, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.sickLeaveColor, lineAValue: 1, lineBValue: (costSummary.sickLeavePercentage/100.00), lineAMeter: widthSickLeaveWhite, lineBMeter: widthSickLeaveColoured)
            
            self.lblPaidVacationPer.text = String(format: "%0.02f", costSummary.paidVacationPercentage) + "%"
            self.lblPaidVacationPer.textColor = Constant.Colors.paidVacancColor
             ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalPaidVacationIndctrWhite, lineB: totalPaidVacationIndctrColoured, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.paidVacancColor, lineAValue: 1, lineBValue: (costSummary.paidVacationPercentage/100.00), lineAMeter: widthVacationWhite, lineBMeter: widthVacationColoured)
            
            let bonusSlice = Slice(radius: 0.75, width: (costSummary.bonusPercentage/100), isOuterCircleNeeded: true, outerCircleWidth: (costSummary.remainingBonusPercentage/100), fillColor:Constant.Colors.bonusColor)
            let otSlice = Slice(radius: 0.65, width: (costSummary.overTimePercentage/100), isOuterCircleNeeded: false, outerCircleWidth: 0, fillColor: Constant.Colors.overTimeColor)
           let wageSlice = Slice(radius: 0.75, width: costSummary.wagePercentage/100, isOuterCircleNeeded: false, outerCircleWidth: 0, fillColor: Constant.Colors.wageColor)
           let sickLeaveSlice = Slice(radius: 0.80, width: costSummary.sickLeavePercentage/100, isOuterCircleNeeded: false, outerCircleWidth: 0, fillColor: Constant.Colors.sickLeaveColor)
           let vacationSlice = Slice(radius: 0.72, width: costSummary.paidVacationPercentage/100, isOuterCircleNeeded: false, outerCircleWidth: 0, fillColor: Constant.Colors.paidVacancColor)
           
            pieChartViewCostSummary.layer.sublayers = nil
            pieChartViewCostSummary.slices = [bonusSlice,otSlice,wageSlice,sickLeaveSlice,vacationSlice]
            
        }

        let calculatedDict = calculateAmntsAndPercentageValue()
        //guard let remainigBonusPer = NumberFormatter().number(from: (calculatedDict.value(forKey: "remaining_bonus_per") as! String)) else { return }
        var remainigBonusPer = calculatedDict.value(forKey: "remaining_bonus_per")
        
        
        var otPer = (calculatedDict.value(forKey: "ot_per") as! CGFloat)
        var bonusPer = (calculatedDict.value(forKey: "bonus_per") as! CGFloat)
        var sickLeavePer = (calculatedDict.value(forKey: "sick_leave_per")as! CGFloat)
        var wagePer = (calculatedDict.value(forKey: "wage_per") as! CGFloat)
        var vacationPer = (calculatedDict.value(forKey: "vacation_per") as! CGFloat)
        
        
        let totalCost = calculatedDict.value(forKey: "total_cost")
        _ = calculatedDict.value(forKey: "total_ot_amount")
        let totalBonusAmnt = calculatedDict.value(forKey: "total_bounus_amount")
        let remainigBonusAmnt = calculatedDict.value(forKey: "remaining_bonus_amnt")
        
        
      //  pieChartViewCostSummary.layer.sublayers = nil
//        pieChartViewCostSummary.slices = [
//
//            Slice(radius: 0.75, width: bonusPer , isOuterCircleNeeded: true, outerCircleWidth: remainigBonusPer as! CGFloat),
//            Slice(radius: 0.65, width: otPer , isOuterCircleNeeded: true, outerCircleWidth: remainigBonusPer as! CGFloat), Slice(radius: 0.75, width: wagePer , isOuterCircleNeeded: true, outerCircleWidth: remainigBonusPer as! CGFloat), Slice(radius: 0.80, width: sickLeavePer , isOuterCircleNeeded: true, outerCircleWidth: remainigBonusPer as! CGFloat), Slice(radius: 0.72, width: vacationPer , isOuterCircleNeeded: true, outerCircleWidth: remainigBonusPer as! CGFloat)
        
        //]
    }
    
    func calculateAmntsAndPercentageValue() -> NSMutableDictionary {
        
        let calcDict = NSMutableDictionary()
        
        let totalCost: CGFloat!
            //= (self.costSummaryModel.total_amount as! CGFloat)
        if let totalCostVal = self.costSummaryModel.total_amount as? CGFloat{
            totalCost = totalCostVal
        }else{
            let val = self.costSummaryModel.total_amount as? String
            totalCost = ObeidiaTypeFormatter.cgfloatFromString(str: val!)
        }
        var bonusAmount = (self.costSummaryModel.bonus_amount as! CGFloat)
        var wageAmount: CGFloat!
        if let wageAmountVal = self.costSummaryModel.wage_amount as? CGFloat{
            wageAmount = wageAmountVal
        }else{
            let val = self.costSummaryModel.wage_amount as? String
            wageAmount = ObeidiaTypeFormatter.cgfloatFromString(str: val!)
        }
        var overTimeAmount = (self.costSummaryModel.over_time_amount as! CGFloat)
        var remainingBonusAmount = (self.costSummaryModel.remaining_bonus_amount as! CGFloat)
        var sickLeaveAmount = (self.costSummaryModel.medical_leave_amount as! CGFloat)
        var vacationAmount = (self.costSummaryModel.paid_vaction_amount as! CGFloat)
        
        var remainingBonusPer = remainingBonusAmount/(bonusAmount + remainingBonusAmount)
        var otPer = (overTimeAmount/totalCost)
        var bonusPer = (bonusAmount/remainingBonusAmount)
        var sickLeavePer = (sickLeaveAmount/totalCost)
        var wagePer = (wageAmount/totalCost)
        var vacationPer = (vacationAmount/totalCost)
        
        if otPer.isNaN {
            otPer = 0
        }
        if bonusPer.isNaN {
            
            bonusPer = 0
        }
        if sickLeavePer.isNaN{
            sickLeavePer = 0
        }
        if wagePer.isNaN{
            wagePer = 0
        }
        if vacationPer.isNaN{
            vacationPer = 0
        }
        
        calcDict.setValue((totalCost), forKey: "total_cost")
        calcDict.setValue((remainingBonusAmount), forKey: "remaining_bonus_amnt")
        calcDict.setValue((overTimeAmount), forKey: "total_ot_amount")
        calcDict.setValue((bonusAmount), forKey: "total_bounus_amount")
        calcDict.setValue((remainingBonusPer), forKey: "remaining_bonus_per")
        calcDict.setValue((otPer), forKey: "ot_per")
        calcDict.setValue((bonusPer), forKey: "bonus_per")
        calcDict.setValue(vacationPer, forKey: "vacation_per")
        calcDict.setValue(sickLeavePer, forKey: "sick_leave_per")
        calcDict.setValue(wagePer, forKey: "wage_per")
        
        
        return calcDict
        
    }
    //POPUP Delegate Methods
    func filterValueUpdated(to value: AnyObject!, updatedType: FilterTypeName!) {
        
        
        print(value.value(forKey: "name") as! String)
        switch updatedType! {
            
        case .site:
            let dict = value as! NSMutableDictionary
            print("")
            self.lblSite.text = (dict.value(forKey: "name") as! String)
            self.siteIdSelected = (dict.value(forKey: "id") as! String)
            
            let startDate: String!
            let endDate: String!
            if self.lblStratDate.text != "" {
                startDate = self.lblStratDate.text
                
            }else{
                startDate = ""
                
            }
            if self.lblEndDate.text != ""{
                endDate = self.lblEndDate.text
                
            }else{
                endDate = ""
                
            }
            
            callSiteWiseCostSummaryAPI(siteID: siteIdSelected, startDate: startDate, endDate: endDate)
        
        default:
            print("")
        }
        
    }
    func dateUpdated(to date: String, updatedType: FilterTypeName!) {
        print(date)
        print(updatedType)
        
        switch updatedType! {
        case .endDate:
            self.lblEndDate.text = date
            //self.selectedApplyDate = date
        case .startDate:
            self.lblStratDate.text = date
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
    
    
    
}
