//
//  EmployeeDetailsViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 30/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class EmployeeDetailsViewController: UITableViewController {
    @IBOutlet weak var absenseColorWidth: NSLayoutConstraint!
    
    @IBOutlet weak var lobourRateWidthColored: NSLayoutConstraint!
    @IBOutlet weak var performanceColorView: UIView!
    @IBOutlet weak var incentiveColorView: UIView!
    @IBOutlet weak var penaltyColorView: UIView!
    @IBOutlet weak var absenseColorView: UIView!
    @IBOutlet weak var strikeColorView: UIView!
    @IBOutlet weak var performanceColorWidth: NSLayoutConstraint!
    @IBOutlet weak var incentiveColorWidth: NSLayoutConstraint!
    @IBOutlet weak var penaltyColorWidth: NSLayoutConstraint!
    @IBOutlet weak var strikeColorWidth: NSLayoutConstraint!
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
    var imageBase: String?
    var emp_details:GetEmployeeDetailsResponseModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        setViewStyle(view: viewInfoLabel)
        setViewStyle(view: viewStrikeRate)
        setViewStyle(view: viewAbsenseRate)
        setViewStyle(view: viewIncentiveRate)
        setViewStyle(view: viewPenaltyRate)
        setViewStyle(view: viewPerformanceRate)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        //setIndicatorValue(value: 0.57)
        
    }
    
    func populateData(){
        if let model = self.details{
            self.title = "EMPLOYEES DETAIL"
            lblName.text = model.name
            lblID.text = String(model.emp_id)
            lblJoinedDate.text = model.date_of_joining
            if let img = imageBase{
            imageViewLabour.loadImageUsingCache(withUrl: img + model.image, colorValue: nil)
            }
            lblAge.text = String(CCUtility.calcAge(birthday: model.dob)) + " years old"
            lblOccupation.text = UserDefaults.standard.string(forKey: "role")
            
            if let rat = Double(model.rating){
                lblRating.text =  model.rating + "/10"
                widthColoredIndicator.constant = CGFloat(4 * rat)
                viewColouredIndicator.backgroundColor = getColorFromRating(rating: CGFloat(rat))
            }
            getEmployeeDetailsApi(empId: model.emp_id)
        }
    }
    
    
    func populateEmployeeDetails(){
        if let model = self.emp_details{
            lblPerformanceRate.text = String(model.employee[0].rating) + "/" + String(model.employee[0].total_rating)
            let ratingP = model.employee[0].rating
            performanceColorView.backgroundColor = getColorFromRating(rating: CGFloat(ratingP))
            performanceColorWidth.constant = CGFloat(10 * ratingP)
            lblIncentiveRateVal.text = String(model.employee[1].rating) + "/" + String(model.employee[1].total_rating)
            let ratingI = model.employee[1].rating
            incentiveColorView.backgroundColor = getColorFromRating(rating: CGFloat(ratingI))
            incentiveColorWidth.constant = CGFloat(10 * ratingI)
            lblStrikeRateVal.text = String(model.employee[2].rating) + "/" + String(model.employee[2].total_rating)
            let ratingS = model.employee[2].rating
            strikeColorView.backgroundColor = getColorFromRating(rating: CGFloat(ratingS))
            strikeColorWidth.constant = CGFloat(10 * ratingS)
            lblAbseneseRateVal.text = String(model.employee[3].rating) + "/" + String(model.employee[3].total_rating)
            let ratingA = model.employee[3].rating
            absenseColorView.backgroundColor = getColorFromRating(rating: CGFloat(ratingA))
            absenseColorWidth.constant = CGFloat(10 * ratingA)
            lblPenaltyRateVal.text = String(model.employee[4].rating) + "/" + String(model.employee[4].total_rating)
            let ratingPe = model.employee[4].rating
            penaltyColorView.backgroundColor = getColorFromRating(rating: CGFloat(ratingPe))
            penaltyColorWidth.constant = CGFloat(10 * ratingPe)
        }
    }
    
    func getColorFromRating(rating:CGFloat) -> UIColor {
        if rating < 5.0{
            return .red
        }
        else if rating > 8.0{
            return UIColor(red:0.65, green:0.79, blue:0.38, alpha:1.0)
        }
        else if rating > 4.0 && rating < 7.0{
            return .orange
        }
        else{
            return .yellow
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
                    self.emp_details = model
                    self.populateEmployeeDetails()
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
  
    
    func setIndicatorValue(value: CGFloat) {
        ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.viewUncoloredIndctr, lineB: self.viewColouredIndicator, lineAColor: ObeidiFont.Color.obeidiLineWhite(), lineBColor: ObeidiColors.ColorCode.obeidiLineGreen(), lineAValue: 1, lineBValue: value, lineAMeter: widthUncoloredIndicator, lineBMeter: widthColoredIndicator)
        
    }
    
    

}
