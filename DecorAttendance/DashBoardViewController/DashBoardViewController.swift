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

class DashBoardViewController: UITableViewController, MyCAAnimationDelegateProtocol, filterUpdatedDelegate {
    
    func animationDidStop(_ theAnimation: CAAnimation!, finished flag: Bool) {
        
    }
    
    
    weak var delegate: DashBoardDelegate?
    
    @IBOutlet weak var lblRemainingBnsPerc: UILabel!
    @IBOutlet weak var lblRemainingBnsAmnt: UILabel!
    @IBOutlet weak var bonusIndicatorLineWhite: UIView!
    @IBOutlet weak var bonusIndicatorLineColored: UIView!
    @IBOutlet weak var widthBonusColored: NSLayoutConstraint!
    
    //Total Wage
    
    @IBOutlet weak var lblWagePer: UILabel!
    @IBOutlet weak var lblWageAmnt: UILabel!
    @IBOutlet weak var totaltotalWageIndctrWhite: UIView!
    @IBOutlet weak var totalWageIndctrColoured: UIView!
    @IBOutlet weak var widthWageColoured: NSLayoutConstraint!
    @IBOutlet weak var widthWageWhite: NSLayoutConstraint!
    
    //Total OT
    @IBOutlet weak var lblTotalOTPerc: UILabel!
    @IBOutlet weak var totalOTIndicatorWhite: UIView!
    @IBOutlet weak var totalOTIndicatorColred: UIView!
    @IBOutlet weak var widthTotalOTColored: NSLayoutConstraint!
    @IBOutlet weak var widthTotalOTLight: NSLayoutConstraint!
    @IBOutlet weak var lblTotalOTAmnt: UILabel!
    
    //Total Bonus
     @IBOutlet weak var lblTotalBnsPerc: UILabel!
    @IBOutlet weak var totalBonusIndicatorWhite: UIView!
    @IBOutlet weak var totalBonusIndicatorColored: UIView!
    @IBOutlet weak var widthTotalBounsColred: NSLayoutConstraint!
    @IBOutlet weak var widthTotalBonusLight: NSLayoutConstraint!
    @IBOutlet weak var lblTotalBnsAmnt: UILabel!
    
    //Total Sick Leave
    @IBOutlet weak var lblLeavePer: UILabel!
    @IBOutlet weak var lblLeaveAmnt: UILabel!
    @IBOutlet weak var widthSickLeaveColoured: NSLayoutConstraint!
    @IBOutlet weak var widthSickLeaveWhite: NSLayoutConstraint!
    @IBOutlet weak var totalSickLeaveIndctrWhite: UIView!
    @IBOutlet weak var totalSickLeaveIndctrColoured: UIView!
    
    //Total Paid Vacation
    @IBOutlet weak var lblPaidVacationPer: UILabel!
    @IBOutlet weak var lblVacationAmnt: UILabel!
    @IBOutlet weak var totalPaidVacationIndctrWhite: UIView!
    @IBOutlet weak var totalPaidVacationIndctrColoured: UIView!
    @IBOutlet weak var widthVacationColoured: NSLayoutConstraint!
    @IBOutlet weak var widthVacationWhite: NSLayoutConstraint!
    
    
    @IBOutlet weak var lblTotalCostAmnt: UILabel!
    @IBOutlet weak var selectSite: UIView!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var viewRemainingBonus: UIView!
    @IBOutlet weak var viewTotalOtBonus: UIView!
    @IBOutlet weak var pieChartViewCostSummary: PieChartSliceView!
    
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStratDate: UILabel!
    
    @IBOutlet weak var widthBonusLight: NSLayoutConstraint!
    @IBOutlet weak var heightBonusIndLight: NSLayoutConstraint!
    
    
    var window: UIWindow?
    var sitesArr: NSMutableArray!
    var spinner = UIActivityIndicatorView(style: .gray)
    var siteModelObjArr = [ObeidiModelSites]()
    var siteSelectedIndex: Int!
    var daySelectedIndex: Int!
    var monthSelectedIndex: Int!
    var siteIdSelected: String!
    var costSummaryModel: ObeidiModelCostSummarySiteWise!
    var siteWiseRequestModel = SiteWiseRequestModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        self.navigationItem.leftItemsSupplementBackButton = true
        setUpViewStyles()
        pieChartViewCostSummary.myAnimationDelegate = self
        callGetAllSitesAPI()
        addTapGesturesToLabels()
    }
    
    func initialisation(){
        
    }
    
    func callSiteWiseCostSummaryApi(){
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        print("Sitewise Request Body:\n---------()")
    ObeidiModelCostSummarySiteWise.callCostSummaryRequset(requestBody:self.siteWiseRequestModel.getReqestBody()) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        callSiteWiseCostSummaryApi()
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
        
        
        self.startDateView.layer.cornerRadius = 1
        self.startDateView.layer.borderWidth = 0.5
        self.startDateView.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.selectSite.layer.cornerRadius = 1
        self.selectSite.layer.borderWidth = 0.5
        self.selectSite.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.endDateView.layer.cornerRadius = 1
        self.endDateView.layer.borderWidth = 0.5
        self.endDateView.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblEndDate.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblStratDate.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblSite.textColor = ObeidiFont.Color.obeidiLightBlack()
        
        addDropDownLabelAndImage(lblToModify: lblStratDate, lblText: "")
        addDropDownLabelAndImage(lblToModify: lblSite, lblText: "All")
        addDropDownLabelAndImage(lblToModify: lblEndDate, lblText: "")
    }
    
    func addDropDownLabelAndImage(lblToModify: UILabel, lblText: String) {
        lblToModify.text = lblText
    }
    
    func addTapGesturesToLabels() {
        self.startDateView.isUserInteractionEnabled = true
        let tapGestureMonth = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleMonthLabelTap))
        self.startDateView.addGestureRecognizer(tapGestureMonth)
        
        self.selectSite.isUserInteractionEnabled = true
        let tapGestureSite = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleSiteLabelTap))
        self.selectSite.addGestureRecognizer(tapGestureSite)
        
        self.endDateView.isUserInteractionEnabled = true
        let tapGestureDay = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleDateLabelTap))
        self.endDateView.addGestureRecognizer(tapGestureDay)
    }
    
    @objc func handleMonthLabelTap(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //self.view.alpha = 0.65
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
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //self.view.alpha = 0.65
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
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //self.view.alpha = 0.65
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
                }
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
    }
    
   
    //POPUP Delegate Methods
    
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
    
    func doneButtonActionDelegateWithSelectedDate(date: String, type: FilterTypeName) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.alpha = 1
            //self.tabBarController?.view.alpha = 0.65
            self.navigationController?.navigationBar.alpha = 1
        },completion:nil)
        if (type == .startDate){
            if (date.count>0){
                siteWiseRequestModel.startDate = date
                self.lblStratDate.text = date
                callSiteWiseCostSummaryApi()
            }
        }
        else if (type == .endDate){
            if (date.count>0){
                siteWiseRequestModel.endDate = date
                self.lblEndDate.text = date
                callSiteWiseCostSummaryApi()
            }
        }
    }
    
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName){
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.alpha = 1
            //self.tabBarController?.view.alpha = 0.65
            self.navigationController?.navigationBar.alpha = 1
        },completion:nil)
        self.lblSite.text = selSite.nameNew
        self.siteWiseRequestModel.siteId = selSite.locIdNew
        callSiteWiseCostSummaryApi()
    }
    
    
}
