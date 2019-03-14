//
//  LabourSummaryViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 21/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class LabourSummaryViewController: UITableViewController, MyCAAnimationDelegateProtocol, DropDownDataDelegate {
    @IBOutlet weak var viewDropDownButtons: UIView!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!

    @IBOutlet weak var lblEmployeeID: UILabel!
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var slicedPieChart: PieChartSliceView!
    
    @IBOutlet weak var bttnExportLabourCard: UIButton!
    
    @IBOutlet weak var widthTotalOTColred: NSLayoutConstraint!
    @IBOutlet weak var widthTotalOTLight: NSLayoutConstraint!
    @IBOutlet weak var widthTotalBonusColored: NSLayoutConstraint!
    @IBOutlet weak var widthTotalBonusLight: NSLayoutConstraint!
    @IBOutlet weak var widthTotalAbsenseColored: NSLayoutConstraint!
    @IBOutlet weak var widthTotalAbsenseLight: NSLayoutConstraint!
    @IBOutlet weak var widthTotalSickLeaveColored: NSLayoutConstraint!
    @IBOutlet weak var widthTotalSickLeaveLight: NSLayoutConstraint!
    @IBOutlet weak var widthTotalPaidVacationColored: NSLayoutConstraint!
    @IBOutlet weak var widthTotalPaidVacationLight: NSLayoutConstraint!
    @IBOutlet weak var widthtotalStrikeColored: NSLayoutConstraint!
    @IBOutlet weak var widthTotalStrikeLight: NSLayoutConstraint!
    
    @IBOutlet weak var viewAllIndicators: UIView!
    
    @IBOutlet weak var totalAbsenseIndicatorLineWhite: UIView!
    @IBOutlet weak var totalAbsenseIndicatorLineColored: UIView!
    @IBOutlet weak var totalBonusIndicatorWhite: UIView!
    @IBOutlet weak var totalBonusIndicatorColored: UIView!
    @IBOutlet weak var totalOTIndicatorWhite: UIView!
    @IBOutlet weak var totalOTIndicatorColred: UIView!
    @IBOutlet weak var sickLeaveIndicatorLineWhite: UIView!
    @IBOutlet weak var sickLeaveIndicatorLineColored: UIView!
    @IBOutlet weak var paidVacationIndicatorWhite: UIView!
    @IBOutlet weak var paidVacationIndicatorColored: UIView!
    @IBOutlet weak var totalStrikeIndicatorWhite: UIView!
    @IBOutlet weak var totalStrikeIndicatorColred: UIView!
    
    var costSummary:CostSummary?
    override func viewDidLoad() {
        super.viewDidLoad()
        getCostSummaryDetailApi()
        addObeidiBackButton()
        setUpViewStyles()
        addTapGesturesToLabels()
        slicedPieChart.myAnimationDelegate = self
        setPerformanceIndicatorLines(lightLine: totalOTIndicatorWhite, coloredLine: totalOTIndicatorColred, percentage: 0.67, color: ObeidiColors.ColorCode.obeidiLinePink(), lightLineWidth: widthTotalOTLight, coloredLineWidth: widthTotalOTColred)
        
    }
    
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
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        //slicedPieChart.style = [Style(isOuterCircleNeeded: false)]
        slicedPieChart.slices =
            [
                Slice(radius: 0.7, width:0.15, isOuterCircleNeeded: false, outerCircleWidth: 0),
                Slice(radius: 0.8, width: 0.25, isOuterCircleNeeded: false, outerCircleWidth: 0),
                Slice(radius: 1, width: 0.35, isOuterCircleNeeded: false, outerCircleWidth: 0),
                Slice(radius: 0.85, width: 0.25, isOuterCircleNeeded: false, outerCircleWidth: 0)
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
            return 281
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
        
        
        self.lblMonth.layer.cornerRadius = 1
        self.lblMonth.layer.borderWidth = 0.5
        self.lblMonth.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblSite.layer.cornerRadius = 1
        self.lblSite.layer.borderWidth = 0.5
        self.lblSite.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblDay.layer.cornerRadius = 1
        self.lblDay.layer.borderWidth = 0.5
        self.lblDay.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblDay.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblMonth.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblSite.textColor = ObeidiFont.Color.obeidiLightBlack()
        
        addDropDownLabelAndImage(lblToModify: lblMonth, lblText: "December")
        addDropDownLabelAndImage(lblToModify: lblSite, lblText: "Quatar")
        addDropDownLabelAndImage(lblToModify: lblDay, lblText: "22")
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblEmployeeName, fontSize: ObeidiFont.Size.mediumB(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.boldFont())
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblEmployeeID, fontSize: ObeidiFont.Size.mediumB(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.boldFont())
        
        
    }
    
    func setPerformanceIndicatorLines(lightLine: UIView, coloredLine: UIView, percentage: CGFloat, color: UIColor, lightLineWidth: NSLayoutConstraint, coloredLineWidth: NSLayoutConstraint) {
        //This is where the indicators set to their corresponding values
        ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: lightLine, lineB: coloredLine, lineAColor: ObeidiFont.Color.obeidiLineWhite(), lineBColor: color, lineAValue: 1, lineBValue: percentage, lineAMeter: lightLineWidth, lineBMeter: coloredLineWidth)
        
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
        
        self.lblMonth.isUserInteractionEnabled = true
        let tapGestureMonth = UITapGestureRecognizer(target: self, action: #selector(LabourSummaryViewController.handleMonthLabelTap))
        self.lblMonth.addGestureRecognizer(tapGestureMonth)
        
        self.lblSite.isUserInteractionEnabled = true
        let tapGestureSite = UITapGestureRecognizer(target: self, action: #selector(LabourSummaryViewController.handleSiteLabelTap))
        self.lblSite.addGestureRecognizer(tapGestureSite)
        
        self.lblDay.isUserInteractionEnabled = true
        let tapGestureDay = UITapGestureRecognizer(target: self, action: #selector(LabourSummaryViewController.handleDateLabelTap))
        self.lblDay.addGestureRecognizer(tapGestureDay)
        
    }
    @objc func handleMonthLabelTap(){
        
        presentDropDownController(tableCgPoint: getPointForMonthTable(), dropDownFor: .Month, arr: fetchMonthArr())
        
        
    }
    @objc func handleDateLabelTap(){
        
        presentDropDownController(tableCgPoint: getPointForDateTable(), dropDownFor: .Date, arr: fetchDateArr())
        
    }
    @objc func handleSiteLabelTap(){
        
        presentDropDownController(tableCgPoint: getPointForSiteTable(), dropDownFor: .Site, arr: fetchSiteArr())
        
    }
    func presentDropDownController(tableCgPoint: CGPoint, dropDownFor:
        DropDownNeededFor, arr: NSMutableArray) {
        
        //self.view.backgroundColor = ObeidiFont.Color.obeidiExactBlack()
        //self.tableView.alpha = 0.4

        //self.navigationController?.navigationBar.alpha = 0.7
        //self.tabBarController?.tabBar.alpha = 0.7
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dropDownController = storyboard.instantiateViewController(withIdentifier: "DropDownViewControllerID") as! DropDownViewController
        dropDownController.tableCgPoint = tableCgPoint//CGPoint(x: self.viewDropDownButtons.frame.minX, y: self.viewDropDownButtons.frame.maxY) //+ (self.navigationController?.navigationBar.frame.size.height)!)
        dropDownController.widthTable = lblDay.frame.size.width
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
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblMonth.frame.minX, y: self.viewDropDownButtons.frame.maxY + 90)
        
    }
    func getPointForDateTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblMonth.frame.size.width + self.lblMonth.frame.minX + 12, y: self.viewDropDownButtons.frame.maxY + 90)
        
    }
    func getPointForSiteTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblMonth.frame.minX + self.lblDay.frame.size.width + self.lblMonth.frame.size.width + 24, y: self.viewDropDownButtons.frame.maxY + 90)
        
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
            print("attendance")
            
        }
        
        
        //self.view.backgroundColor = UIColor.white
        //self.tableView.alpha = 1

        //self.navigationController?.navigationBar.alpha = 1
        //self.tabBarController?.tabBar.alpha = 1
        
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
} 
