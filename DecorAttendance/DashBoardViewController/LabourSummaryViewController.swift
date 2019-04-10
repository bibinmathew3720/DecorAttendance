//
//  LabourSummaryViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 21/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class LabourSummaryViewController: UITableViewController, MyCAAnimationDelegateProtocol,filterUpdatedDelegate {
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!

    @IBOutlet weak var lblEmployeeID: UILabel!
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var slicedPieChart: PieChartSliceView!
    @IBOutlet weak var selectSite: UIView!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var bttnExportLabourCard: UIButton!
    
    //Total Wage
    @IBOutlet weak var totalWageLabel: UILabel!
    @IBOutlet weak var widthTotalWageColred: NSLayoutConstraint!
    @IBOutlet weak var widthTotalWageLight: NSLayoutConstraint!
    @IBOutlet weak var totalWageAmountLabel: UILabel!
    @IBOutlet weak var totalWageAmountIndicatorColored: UIView!
    @IBOutlet weak var totalWageAmountIndicatorWhite: UIView!
    
    //Total OT
    @IBOutlet weak var totalOTPercentageLabel: UILabel!
    @IBOutlet weak var totalOTIndicatorColored: UIView!
    @IBOutlet weak var widthTotalOTIndicatorColored: NSLayoutConstraint!
    @IBOutlet weak var widthTotalOTLight: NSLayoutConstraint!
     @IBOutlet weak var totalOTIndicatorWhite: UIView!
    @IBOutlet weak var totalOtPriceLabel: UILabel!
    
    //Total Bonus
    @IBOutlet weak var totalBonusPerLabel: UILabel!
    @IBOutlet weak var totalBonusIndicatorColored: UIView!
    @IBOutlet weak var totalBonusIndicatorWhite: UIView!
    @IBOutlet weak var widthTotalBonusIndicatorWhite: NSLayoutConstraint!
    @IBOutlet weak var widthTotalBonusIndColored: NSLayoutConstraint!
    @IBOutlet weak var totalBonusPriceLabel: UILabel!
   
    //Sick Leave
    @IBOutlet weak var sickLeavePerLabel: UILabel!
    @IBOutlet weak var sickLeaveIndicatorLineWhite: UIView!
    @IBOutlet weak var sickLeaveIndicatorLineColored: UIView!
    @IBOutlet weak var widthTotalSickLeaveColored: NSLayoutConstraint!
    @IBOutlet weak var widthTotalSickLeaveLight: NSLayoutConstraint!
    @IBOutlet weak var sickLEavePriceLabel: UILabel!
    
    //Paid Vacation
    @IBOutlet weak var paidVacationPerLabel: UILabel!
    @IBOutlet weak var widthTotalPaidVacationColored: NSLayoutConstraint!
    @IBOutlet weak var widthTotalPaidVacationLight: NSLayoutConstraint!
    @IBOutlet weak var paidVacationIndicatorWhite: UIView!
    @IBOutlet weak var paidVacationIndicatorColored: UIView!
    @IBOutlet weak var paidVacationAmountLabel: UILabel!
    
    
    @IBOutlet weak var viewAllIndicators: UIView!
    
    //Penalty
    
    //Equipment Penalty
    
    @IBOutlet weak var equipmentPenaltyPercLabel: UILabel!
    @IBOutlet weak var equipmentPenaltyWhitView: UIView!
    @IBOutlet weak var equipmentPenaltyColoredView: UIView!
    @IBOutlet weak var equipmentPenaltyColoredViewWidth: NSLayoutConstraint!
    @IBOutlet weak var equipmentPenaltyPriceLabel: UILabel!
    
    //Srike Penalty
    @IBOutlet weak var totalStrikePercLabel: UILabel!
    @IBOutlet weak var totalStrikeWhiteView: UIView!
    @IBOutlet weak var totalStrikeColoredView: UIView!
    @IBOutlet weak var totalStrikeColoredViewWidth: NSLayoutConstraint!
    @IBOutlet weak var totalStrikePriceLabel: UILabel!
    
    //Absence Penalty
    @IBOutlet weak var totalAbsencePercLabel: UILabel!
    @IBOutlet weak var totalAbsenceWhiteView: UIView!
    @IBOutlet weak var totalAbsenceColoredView: UIView!
    @IBOutlet weak var totalAbsenceWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalAbsencePricelLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var costSummary:CostSummary?
    var costSummaryDetailResponse:CostSummaryDetailResponseModel?
     var siteModelObjArr = [ObeidiModelSites]()
    var spinner = UIActivityIndicatorView(style: .gray)
    var labourSummaryDetailRequestModel = LabourSummaryDetailsRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        populateCostSummary()
        callGetAllSitesAPI()
        getCostSummaryDetailApi()
        addObeidiBackButton()
        setUpViewStyles()
        addTapGesturesToLabels()
        slicedPieChart.myAnimationDelegate = self
    }
    
    func initialisation(){
        self.lblStartDate.text = ""
        self.lblEndDate.text = ""
        self.lblSite.text = "All"
        self.title = Constant.PageNames.Dashboard
    }
    
    func populateCostSummary(){
        if let costSum = self.costSummary{
            self.lblEmployeeName.text = costSum.name
            self.lblEmployeeID.text = "QAA\(costSum.empId)"
        }
    }
    
    //MARK: Get All Sites Api
    
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
    
    //Get Cost Summary Detail Api
    
    func getCostSummaryDetailApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        var detailString = ""
        if let costSum = self.costSummary{
            detailString = "\(costSum.empId)"
        }
        LabourManager().getCostSummaryDetail(with:detailString, success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? CostSummaryDetailResponseModel{
                let type:StatusEnum = CCUtility.getErrorTypeFromStatusCode(errorValue: response.statusCode)
                if type == StatusEnum.success{
                   self.costSummaryDetailResponse = model
                   self.populateCostDetails()
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
    
    func populateCostDetails(){
        if let costDetail = self.costSummaryDetailResponse{
            
            let wageSlice = Slice(radius: 0.75, width: costDetail.wagePercentage/100, isOuterCircleNeeded: false, outerCircleWidth: 0, fillColor: Constant.Colors.wageColor)
            let otSlice = Slice(radius: 0.65, width: (costDetail.overTimePercentage/100), isOuterCircleNeeded: false, outerCircleWidth: 0, fillColor: Constant.Colors.overTimeColor)
            let bonusSlice = Slice(radius: 0.75, width: (costDetail.bonusPercentage/100), isOuterCircleNeeded: false, outerCircleWidth: 0, fillColor:Constant.Colors.bonusColor)
            let sickLeaveSlice = Slice(radius: 0.80, width: costDetail.medicalLeavePercentage/100, isOuterCircleNeeded: false, outerCircleWidth: 0, fillColor: Constant.Colors.sickLeaveColor)
            let vacationSlice = Slice(radius: 0.72, width: costDetail.paidVacationPercentage/100, isOuterCircleNeeded: false, outerCircleWidth: 0, fillColor: Constant.Colors.paidVacancColor)
            
            slicedPieChart.layer.sublayers = nil
            slicedPieChart.slices = [bonusSlice,otSlice,wageSlice,sickLeaveSlice,vacationSlice]
            
            
            self.totalWageLabel.text = String.init(format: "%0.2f", costDetail.wagePercentage) + "%"
            self.totalWageLabel.textColor = Constant.Colors.wageColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalWageAmountIndicatorWhite, lineB: totalWageAmountIndicatorColored, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.wageColor, lineAValue: 1, lineBValue: (costDetail.wagePercentage/100.00), lineAMeter: widthTotalWageLight, lineBMeter: widthTotalWageColred)
            self.totalWageAmountLabel.text = "Hr " + "\(costDetail.totalPresentDayCount)" + " AED " + "\(costDetail.wageAmount)"
            
            self.totalOTPercentageLabel.text = String.init(format: "%0.2f", costDetail.overTimePercentage) + "%"
            self.totalOTPercentageLabel.textColor = Constant.Colors.overTimeColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalOTIndicatorWhite, lineB: totalOTIndicatorColored, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.overTimeColor, lineAValue: 1, lineBValue: (costDetail.overTimePercentage/100.00), lineAMeter: widthTotalOTLight, lineBMeter: widthTotalOTIndicatorColored)
            self.totalOtPriceLabel.text = "Hr " + "\(costDetail.overTimeMinutes)" + " AED " + "\(costDetail.overTimeAmount)"
            
            self.totalBonusPerLabel.text = String.init(format: "%0.2f", costDetail.bonusPercentage) + "%"
            self.totalBonusPerLabel.textColor = Constant.Colors.bonusColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalBonusIndicatorWhite, lineB: totalBonusIndicatorColored, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.bonusColor, lineAValue: 1, lineBValue: (costDetail.bonusPercentage/100.00), lineAMeter: widthTotalBonusIndColored, lineBMeter: widthTotalBonusIndColored)
            self.totalBonusPriceLabel.text = "Hr " + "\(costDetail.totalBonusWorkTime)" + " AED " + "\(costDetail.bonusAmount)"
            
            self.sickLeavePerLabel.text = String.init(format: "%0.2f", costDetail.medicalLeavePercentage) + "%"
            self.sickLeavePerLabel.textColor = Constant.Colors.sickLeaveColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.sickLeaveIndicatorLineWhite, lineB: sickLeaveIndicatorLineColored, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.sickLeaveColor, lineAValue: 1, lineBValue: (costDetail.medicalLeavePercentage/100.00), lineAMeter: widthTotalSickLeaveColored, lineBMeter: widthTotalSickLeaveColored)
            self.sickLEavePriceLabel.text = "Day " + "\(costDetail.totalMedicalLeaveDayCount)" + " AED " + "\(costDetail.medicalLeaveAmount)"
            
            self.paidVacationPerLabel.text = String.init(format: "%0.2f", costDetail.paidVacationPercentage) + "%"
            self.paidVacationPerLabel.textColor = Constant.Colors.paidVacancColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.paidVacationIndicatorWhite, lineB: paidVacationIndicatorColored, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.paidVacancColor, lineAValue: 1, lineBValue: (costDetail.paidVacationPercentage/100.00), lineAMeter: widthTotalPaidVacationColored, lineBMeter: widthTotalPaidVacationColored)
            self.paidVacationAmountLabel.text = "AED " + "\(costDetail.paidVacationAmount)"
            
            //Penalties
            
            self.equipmentPenaltyPercLabel.text = String.init(format: "%0.2f", costDetail.equipmentPenaltyPercentage) + "%"
            self.equipmentPenaltyPercLabel.textColor = Constant.Colors.remainingBonusColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.equipmentPenaltyWhitView, lineB: equipmentPenaltyColoredView, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.remainingBonusColor, lineAValue: 1, lineBValue: (costDetail.equipmentPenaltyPercentage/100.00), lineAMeter: equipmentPenaltyColoredViewWidth, lineBMeter: equipmentPenaltyColoredViewWidth)
            self.equipmentPenaltyPriceLabel.text = "AED " + "\(costDetail.equipmentPenaltyAmount)"
            
            self.totalStrikePercLabel.text = String.init(format: "%0.2f", costDetail.totalStrikePercentage) + "%"
            self.totalStrikePercLabel.textColor = Constant.Colors.remainingBonusColor
             ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalStrikeWhiteView, lineB: totalStrikeColoredView, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.remainingBonusColor, lineAValue: 1, lineBValue: (costDetail.totalStrikePercentage/100.00), lineAMeter: totalStrikeColoredViewWidth, lineBMeter: totalStrikeColoredViewWidth)
            self.totalStrikePriceLabel.text = "Day " + String(format: "%0.0f", costDetail.totalStrikeDayCount) + " AED " + "\(costDetail.strikePenaltyAmount)"
            
            self.totalAbsencePercLabel.text = String.init(format: "%0.2f", costDetail.totalAbsencePerncetage) + "%"
             self.totalAbsencePercLabel.textColor = Constant.Colors.remainingBonusColor
            ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.totalAbsenceWhiteView, lineB: totalAbsenceColoredView, lineAColor: Constant.Colors.greyColor, lineBColor: Constant.Colors.remainingBonusColor, lineAValue: 1, lineBValue: (costDetail.totalAbsencePerncetage/100.00), lineAMeter: totalAbsenceWidthConstraint, lineBMeter: totalAbsenceWidthConstraint)
            self.totalAbsencePricelLabel.text = "Day " + String(format: "%0.0f", costDetail.totalAbsentDayCount) + " AED " + "\(costDetail.absencePenaltyAmount)"
            
            self.totalAmountLabel.text = "AED " + String(format: "%0.2f", costDetail.netSalary)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        //slicedPieChart.style = [Style(isOuterCircleNeeded: false)]
        slicedPieChart.slices =
            [
                //Slice(radius: 0.7, width:0.15, isOuterCircleNeeded: false, outerCircleWidth: 0),
                //Slice(radius: 0.8, width: 0.25, isOuterCircleNeeded: false, outerCircleWidth: 0),
               // Slice(radius: 1, width: 0.35, isOuterCircleNeeded: false, outerCircleWidth: 0),
               // Slice(radius: 0.85, width: 0.25, isOuterCircleNeeded: false, outerCircleWidth: 0)
        ]
            
//            = [
//            Slice(radius: 1.0),
//            Slice(radius: 0.7),
//            Slice(radius: 0.6),
//            Slice(radius: 0.4),
//            Slice(radius: 1.0),
//            Slice(radius: 0.5),
//            Slice(radius: 0.3),
//            Slice(radius: 0.15),
//            Slice(radius: 1.0),
//            Slice(radius: 0.7),
//            Slice(radius: 0.6),
//            Slice(radius: 1.0),
//            Slice(radius: 0.75),
//            Slice(radius: 0.5),
//            Slice(radius: 0.3),
//            Slice(radius: 0.2)
//        ]
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
            return 162
        case 1:
            return 453
        case 2:
            //return 281
            return 400
        default:
            return 0
        }
        
        
    }

    func animationDidStop(_ theAnimation: CAAnimation!, finished flag: Bool) {
        if slicedPieChart.myAnimationDelegate != nil
        {
            slicedPieChart.animating = false
            slicedPieChart.myAnimationDelegate?.animationDidStop( theAnimation, finished: true)
        }
        
        
    }
    func setUpViewStyles() {
        
        self.bttnExportLabourCard.backgroundColor = ObeidiColors.ColorCode.obeidiLineRed()
        self.bttnExportLabourCard.layer.cornerRadius = self.bttnExportLabourCard.frame.size.height / 2
        
        self.viewAllIndicators.layer.cornerRadius = 1
        self.viewAllIndicators.backgroundColor = UIColor.white
        self.viewAllIndicators.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.viewAllIndicators.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.12).cgColor
        self.viewAllIndicators.layer.shadowOpacity = 1
        self.viewAllIndicators.layer.shadowRadius = 9
        
        
        self.startDateView.layer.cornerRadius = 1
        self.startDateView.layer.borderWidth = 0.5
        self.startDateView.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.selectSite.layer.cornerRadius = 1
        self.selectSite.layer.borderWidth = 0.5
        self.selectSite.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.endDateView.layer.cornerRadius = 1
        self.endDateView.layer.borderWidth = 0.5
        self.endDateView.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblStartDate.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblEndDate.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblSite.textColor = ObeidiFont.Color.obeidiLightBlack()
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblEmployeeName, fontSize: ObeidiFont.Size.mediumB(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.boldFont())
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblEmployeeID, fontSize: ObeidiFont.Size.mediumB(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.boldFont())
        
        
    }
    
    func setPerformanceIndicatorLines(lightLine: UIView, coloredLine: UIView, percentage: CGFloat, color: UIColor, lightLineWidth: NSLayoutConstraint, coloredLineWidth: NSLayoutConstraint) {
        //This is where the indicators set to their corresponding values
        ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: lightLine, lineB: coloredLine, lineAColor: ObeidiFont.Color.obeidiLineWhite(), lineBColor: color, lineAValue: 1, lineBValue: percentage, lineAMeter: lightLineWidth, lineBMeter: coloredLineWidth)
        
    }
    
    func addTapGesturesToLabels() {
        
        self.startDateView.isUserInteractionEnabled = true
        let tapGestureStartDate = UITapGestureRecognizer(target: self, action: #selector(LabourSummaryViewController.handleStartDateLabelTap))
        self.startDateView.addGestureRecognizer(tapGestureStartDate)
        
        self.selectSite.isUserInteractionEnabled = true
        let tapGestureSite = UITapGestureRecognizer(target: self, action: #selector(LabourSummaryViewController.handleSiteLabelTap))
        self.selectSite.addGestureRecognizer(tapGestureSite)
        
        self.endDateView.isUserInteractionEnabled = true
        let tapGestureEndDate = UITapGestureRecognizer(target: self, action: #selector(LabourSummaryViewController.handleEndDateLabelTap))
        self.endDateView.addGestureRecognizer(tapGestureEndDate)
        
    }
    @objc func handleStartDateLabelTap(){
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //self.view.alpha = 0.65
                //self.navigationController?.navigationBar.alpha = 0.65
                
                
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
    
    @objc func handleEndDateLabelTap(){
        
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //self.view.alpha = 0.65
                //self.tabBarController?.view.alpha = 0.65
                //self.navigationController?.navigationBar.alpha = 0.65
                
                
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
    
    func addObeidiBackButton() {
        let yourBackImage = UIImage(named: "back")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = nil
        self.navigationController?.navigationController?.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationController?.navigationItem.backBarButtonItem?.tintColor = ObeidiColors.ColorCode.obeidiExactWhite()

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
//        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
//            self.view.alpha = 1
//            //self.tabBarController?.view.alpha = 0.65
//            self.navigationController?.navigationBar.alpha = 1
//        },completion:nil)
        if (type == .startDate){
            if (date.count>0){
                labourSummaryDetailRequestModel.startDate = date
                self.lblStartDate.text = date
               getCostSummaryDetailApi()
            }
        }
        else if (type == .endDate){
            if (date.count>0){
                labourSummaryDetailRequestModel.endDate = date
                self.lblEndDate.text = date
                getCostSummaryDetailApi()
            }
        }
    }
    
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName){
//        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
//            self.view.alpha = 1
//            //self.tabBarController?.view.alpha = 0.65
//            self.navigationController?.navigationBar.alpha = 1
//        },completion:nil)
        self.lblSite.text = selSite.nameNew
        self.labourSummaryDetailRequestModel.siteId = selSite.locIdNew
        getCostSummaryDetailApi()
    }
} 
