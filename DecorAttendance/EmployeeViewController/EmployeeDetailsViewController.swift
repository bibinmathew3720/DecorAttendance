//
//  EmployeeDetailsViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 30/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class EmployeeDetailsViewController: UITableViewController {
    
    @IBOutlet weak var strikeViewWidth: NSLayoutConstraint!
    @IBOutlet weak var widthUncoloredIndicator: NSLayoutConstraint!
    @IBOutlet weak var widthColoredIndicator: NSLayoutConstraint!
    @IBOutlet weak var viewColouredIndicator: UIView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var viewUncoloredIndctr: UIView!
    @IBOutlet weak var lblJoinedDate: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblOccupation: UILabel!
    @IBOutlet weak var imageViewLabour: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblStrikeRateVal: UILabel!
    @IBOutlet weak var lblAbseneseRateVal: UILabel!
    @IBOutlet weak var lblPenaltyRateVal: UILabel!
    @IBOutlet weak var lblIncentiveRateVal: UILabel!
    @IBOutlet weak var lblPerformanceRate: UILabel!
    @IBOutlet weak var viewInfoLabel: UIView!
    @IBOutlet weak var viewStrikeRate: UIView!
    @IBOutlet weak var viewPerformanceRate: UIView!
    @IBOutlet weak var viewIncentiveRate: UIView!
    @IBOutlet weak var viewPenaltyRate: UIView!
    @IBOutlet weak var viewAbsenseRate: UIView!
    var details: DecoreEmployeeModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        setViewStyle(view: viewInfoLabel)
        setViewStyle(view: viewStrikeRate)
        setViewStyle(view: viewAbsenseRate)
        setViewStyle(view: viewIncentiveRate)
        setViewStyle(view: viewPenaltyRate)
        setViewStyle(view: viewPerformanceRate)
        
        setLabelStyle()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        
        setIndicatorValue(value: 0.57)
        
    }
    
    func populateData(){
        if let model = self.details{
            lblName.text = model.name
            lblID.text = String(model.emp_id)
            lblJoinedDate.text = model.date_of_joining
            lblAge.text = String(CCUtility.calcAge(birthday: model.dob))
            lblOccupation.text = UserDefaults.standard.string(forKey: "role")
            lblRating.text = model.rating + "/10"
            let rating = Double(model.rating)
            if let rat = rating{
                widthColoredIndicator.constant = CGFloat(4 * rat)
            }
            getEmployeeDetailsApi(empId: model.emp_id)
        }
    }
    
    func getEmployeeDetailsApi(empId:Int){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().getEmployeeDetailsApi(with:"\(empId)", success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? GetEmployeeDetailsResponseModel{
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 300
        default:
            return 112
        }
        
    }
    
    func setViewStyle(view: UIView){
        
        view.layer.cornerRadius = 3
        view.backgroundColor = UIColor.white
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.35).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 7
        
        
    }
    func setLabelStyle()  {
        
//        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblStrikeRateVal, fontSize: ObeidiFont.Size.bigA(), fontColor: ObeidiFont.Color.obeidiLineRed(), fontName: ObeidiFont.Family.boldFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblAbseneseRateVal, fontSize: ObeidiFont.Size.bigA(), fontColor: ObeidiFont.Color.obeidiLineRed(), fontName: ObeidiFont.Family.boldFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblPenaltyRateVal, fontSize: ObeidiFont.Size.bigA(), fontColor: ObeidiFont.Color.obeidiLineRed(), fontName: ObeidiFont.Family.boldFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblIncentiveRateVal, fontSize: ObeidiFont.Size.bigA(), fontColor: ObeidiFont.Color.obeidiLineRed(), fontName: ObeidiFont.Family.boldFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblPerformanceRate, fontSize: ObeidiFont.Size.bigA(), fontColor: ObeidiFont.Color.obeidiLineRed(), fontName: ObeidiFont.Family.boldFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblName, fontSize: ObeidiFont.Size.bigA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.boldFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblID, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblAge, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiLightBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblRating, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiLightBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblJoinedDate, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiLightBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblOccupation, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiLightBlack(), fontName: ObeidiFont.Family.normalFont())
        
        
    }
    
    func setIndicatorValue(value: CGFloat) {
        ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.viewUncoloredIndctr, lineB: self.viewColouredIndicator, lineAColor: ObeidiFont.Color.obeidiLineWhite(), lineBColor: ObeidiColors.ColorCode.obeidiLineGreen(), lineAValue: 1, lineBValue: value, lineAMeter: widthUncoloredIndicator, lineBMeter: widthColoredIndicator)
        
    }
    
}
