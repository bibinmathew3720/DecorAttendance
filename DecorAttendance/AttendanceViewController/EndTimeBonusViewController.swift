//
//  EndTimeBonusViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 20/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class EndTimeBonusViewController: UITableViewController, UITextFieldDelegate, dismissDelegate {

    
    @IBOutlet weak var pieChartBonus: UIView!
    
    @IBOutlet weak var bttnDone: UIButton!
    @IBOutlet weak var txtFldGivenBonus: UITextField!
    @IBOutlet weak var lblRemainingBonus: UILabel!
    
    var maxRadius:CGFloat!
    var center: CGPoint!
    var activeTextField: UITextField!
    var spinner = UIActivityIndicatorView(style: .gray)
    var paramsDict = NSMutableDictionary()
   
    var selSiteModel:ObeidiModelSites?
    var attendanceResponse:ObeidiModelFetchAttendance?
    var attendanceType:AttendanceType?
    var penaltyValue:CGFloat?
    var selLocation:Location?
    var imageDataRef: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        addTapgesturesToView()
        txtFldGivenBonus.delegate = self
        setViewStyles()
        calculateBonusPer()
       // self.lblRemainingBonus.text = "AED" + "\(User.BonusDetails.remaining_bonus)/ \(User.BonusDetails.bonus_budget)"
        if let selSite = self.selSiteModel{
            self.lblRemainingBonus.text = "AED " + "\(selSite.remainingBonusNew) / \(selSite.bonusBudgetNew)"
        }
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
       self.title = Constant.PageNames.Attendance
    }
    
    //MARK: textfield delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    @IBAction func bttnActnDone(_ sender
        : Any){
        if (isValid()){
            self.callPostAttendanceAPI()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 350
        case 1:
            return 250
        default:
            return 0
            
        }
    }
    
    func drawOuterPieChart(center: CGPoint, radius: CGFloat, filValue: CGFloat) {
        let circlePathColoured = UIBezierPath()
        circlePathColoured.addArc(withCenter: center, radius: radius * 0.95, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        circlePathColoured.addLine(to: center)
        let circleLayerColoured = CAShapeLayer()
        circleLayerColoured.path = circlePathColoured.cgPath
        circleLayerColoured.strokeColor = ObeidiColors.ColorCode.obeidiDarkOrange().cgColor
        circleLayerColoured.strokeStart = 0
        circleLayerColoured.strokeEnd = filValue - 0.2//0.7
        circleLayerColoured.lineWidth = 18
        circleLayerColoured.fillColor = UIColor.clear.cgColor
        circleLayerColoured.lineCap = .round
        
        //unColoured
        let circlePathUnColoured = UIBezierPath()
        
        circlePathUnColoured.addArc(withCenter: center, radius: radius * 0.95, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        circlePathUnColoured.addLine(to: center)
        let circleLayerUnColoured = CAShapeLayer()
        circleLayerUnColoured.path = circlePathUnColoured.cgPath
        circleLayerUnColoured.strokeColor = ObeidiColors.ColorCode.obeidiDarkOrange().cgColor
        circleLayerUnColoured.strokeStart = filValue - 0.2//0.7
        circleLayerUnColoured.strokeEnd = 0.86
        circleLayerUnColoured.lineWidth = 18
        circleLayerUnColoured.fillColor = UIColor.clear.cgColor
        circleLayerUnColoured.opacity = 0.3
        
        
        //add percentage label
        let textLayer = CATextLayer()
        textLayer.font = UIFont(name: ObeidiFont.Family.normalFont(), size: ObeidiFont.Size.smallB())
        //labelLayer.frame = fillNewColorLayer.frame
        textLayer.string = String(format: "%.0f", (filValue * 100)) + "%"
        textLayer.alignmentMode = CATextLayerAlignmentMode.left
        textLayer.foregroundColor = ObeidiFont.Color.obeidiExactWhite().cgColor
        textLayer.fontSize = ObeidiFont.Size.mediumB()
        
        textLayer.frame = CGRect(x: Double(center.x) + cos(0.8 * 2 * Double.pi) * Double(radius) * 0.95 - 12, y: Double(center.y) + sin(0.8 * 2 * Double.pi) * Double(radius) * 0.95 - 6, width: 100, height: 50)
        
        circleLayerColoured.addSublayer(textLayer)
        self.pieChartBonus.layer.addSublayer(circleLayerColoured)
        self.pieChartBonus.layer.addSublayer(circleLayerUnColoured)
    }
    
    func setViewStyles()  {
        self.bttnDone.layer.cornerRadius = self.bttnDone.frame.size.height/2
    }

    func addTapgesturesToView()  {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EndTimeBonusViewController.dismissKeyBoard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyBoard()  {
        if activeTextField != nil{
            activeTextField.resignFirstResponder()
        }
    }
    
    func calculateBonusPer() {
        let bonusPer = (ObeidiaTypeFormatter.cgfloatFromString(str: User.BonusDetails.remaining_bonus))/(ObeidiaTypeFormatter.cgfloatFromString(str: User.BonusDetails.bonus_budget))
        
        maxRadius = min(pieChartBonus.bounds.size.width,
                        pieChartBonus.bounds.size.height)/2 - 5
        center = CGPoint(x: pieChartBonus.bounds.midX,
                         y: pieChartBonus.bounds.midY)
        drawOuterPieChart(center: center, radius: maxRadius, filValue: bonusPer )
    }
    
    func isValid()->Bool{
        var valid = true
        if let bonusText = txtFldGivenBonus.text{
            if let bonusValue = Float (bonusText){
                let bonusValueCGFloat = CGFloat(bonusValue)
                print(bonusValueCGFloat)
                if let selSite = self.selSiteModel{
                    if bonusValueCGFloat > selSite.remainingBonusNew{
                        valid = false
                        CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "Entered bonus amount greater than available bonus point", parentController: self)
                    }
                }
            }
        }
        return valid
    }
    
    func callPostAttendanceAPI()  {
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        ObeidiModelMarkAttendance.callMarkAttendanceRequest(dataDict: getParamsDict(), image: self.imageDataRef){
            (success, result, error) in
            if success! {
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                print(result!)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let alertController = storyboard.instantiateViewController(withIdentifier: "ObeidiAlertViewControllerID") as! ObeidiAlertViewController
                
                alertController.titleRef = "Success ."
                alertController.explanationRef = "Your Attendance has been marked. "
                alertController.parentController = self
                
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                alertController.delegate = self
                self.present(alertController, animated: true, completion: nil)
            }else{
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            }
        }
    }
    
    func getParamsDict() -> NSMutableDictionary {
        if let site = self.selSiteModel{
            paramsDict.setValue("\(site.locIdNew)", forKey: "site_id")
        }
        if let loc = self.selLocation{
            paramsDict.setValue("\(loc.latitude)", forKey: "lat")
             paramsDict.setValue("\(loc.longitude)", forKey: "lng")
        }
        if let attType = self.attendanceType{
            paramsDict.setValue(CCUtility.getAttendanceTypeString(attendanceType:attType), forKey: "type")
        }
        if let atResponse = self.attendanceResponse{
            paramsDict.setValue("\(atResponse.empId)", forKey: "emp_id")
        }
        if let bonusText = txtFldGivenBonus.text{
             paramsDict.setValue(bonusText, forKey: "bonus")
        }
        paramsDict.setValue("dsds", forKey: "image")
        print(paramsDict)
        return paramsDict
    }
    
    func dismissed() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
