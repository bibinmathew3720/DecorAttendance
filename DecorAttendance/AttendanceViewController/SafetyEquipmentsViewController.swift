//
//  SafetyEquipmentsViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 28/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class SafetyEquipmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, buttonCheckedDelegate {
    
    @IBOutlet weak var bttnCheckAll: UIButton!
    @IBOutlet weak var tableViewPenalty: UITableView!
    @IBOutlet weak var lblPenaltyAmnt: UILabel!
    @IBOutlet weak var bttnNext: UIButton!
    
    
    
    var isButtonChecked: Bool!
    
    var penaltyVal: Int!
    var safetyEquipmentsObjModelArr = NSMutableArray()
    var spinner = UIActivityIndicatorView(style: .gray)
    var penaltyFullValue: Int!
    var attendanceTypeRef: String!
    
    var selSiteModel:ObeidiModelSites?
    var attendanceResponse:ObeidiModelFetchAttendance?
    var attendanceType:AttendanceType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewPenalty.delegate = self
        self.tableViewPenalty.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        isButtonChecked = false
        setViewStyles()
        setButtonStyle()
        penaltyVal = 0
        callSafetyEquipmentsAPI()
        
        // Do any additional setup after loading the view.
    }
    
    func setViewStyles() {
        
        let layer = self.bttnNext!
        layer.layer.cornerRadius = 23.5
        layer.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        layer.layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        layer.layer.shadowOpacity = 1
        layer.layer.shadowRadius = 23
        
        let lblPenalty = lblPenaltyAmnt!
        lblPenalty.layer.borderWidth = 1
        lblPenalty.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        //lblPenaltyAmnt.text = "80 AED"
        
        bttnCheckAll.layer.borderWidth = 1
        bttnCheckAll.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
    }

    @IBAction func bttnActnNext(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toCaptureImageSceneSegue:Safety", sender: Any.self)
        
    }
    func setButtonStyle()  {
        
        
        
        
    }
    func updatePenaltyValue(val: Int) {
        
        let valStr = String(val)
        self.lblPenaltyAmnt.text = valStr + " AED"
        
    }
    
    @IBAction func bttnActnCheckAll(_ sender: Any) {
        
        isButtonChecked = !isButtonChecked
        if isButtonChecked{
            
            self.bttnCheckAll.setImage(UIImage(named: "tick"), for: .normal)
            //update the checked status in each cell
            penaltyVal = 0
            self.lblPenaltyAmnt.text = String(penaltyVal)
            self.tableViewPenalty.reloadData()
            
        }else{
            
            self.bttnCheckAll.setImage(UIImage(named: ""), for: .normal)
            //update the checked status in each cell
            self.lblPenaltyAmnt.text = String(penaltyFullValue)
            self.tableViewPenalty.reloadData()
            
        }
        
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if safetyEquipmentsObjModelArr.count != 0{
            
            return safetyEquipmentsObjModelArr.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSafetyEquipmentTableView", for: indexPath) as! SafetyEquipmentsTableViewCell
        cell.bttnCheck.tag = indexPath.row
        
        let cellData = self.safetyEquipmentsObjModelArr.object(at: indexPath.row) as! ObeidiModelSafetyEquipments
        penaltyVal = penaltyVal + (cellData.penalty as! Int)
        cell.setCellContents(cellData: cellData, isAllChecked: self.isButtonChecked)
        cell.checkButtonDelegate = self
        
        if indexPath.row == self.safetyEquipmentsObjModelArr.count - 1{
            
            if isButtonChecked{
                penaltyVal = 0
                self.lblPenaltyAmnt.text = String(penaltyVal) + "AED"
            }else{
                
                penaltyFullValue = penaltyVal
                self.lblPenaltyAmnt.text = String(penaltyFullValue) + "AED"
            }
            
            
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 105
        
    }
    
    func callSafetyEquipmentsAPI() {
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        ObeidiModelSafetyEquipments.callSafetyEquipmentsRequest() {
            (success, result, error) in
            if success! {
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                self.processSafetyEquipmentsResponse(apiResponse: result!)
                print(result!)
            }else{
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            }
        }
    }
    
    func processSafetyEquipmentsResponse(apiResponse: AnyObject!)  {
        self.safetyEquipmentsObjModelArr = (apiResponse as! NSMutableArray)
        self.tableViewPenalty.reloadData()
    }
    
    func buttonCheckedStatus(isChecked: Bool, buttonIndex: Int) {
        if isChecked{
            let equipmentPenalty: Int!
            equipmentPenalty = ((self.safetyEquipmentsObjModelArr.object(at: buttonIndex) as! ObeidiModelSafetyEquipments).penalty as! Int)
            penaltyVal = penaltyVal - equipmentPenalty
            self.lblPenaltyAmnt.text = String(penaltyVal) + "AED"
        }else{
            let equipmentPenalty: Int!
            self.isButtonChecked = false
            self.bttnCheckAll.setImage(UIImage(named: ""), for: .normal)
            equipmentPenalty = ((self.safetyEquipmentsObjModelArr.object(at: buttonIndex) as! ObeidiModelSafetyEquipments).penalty as! Int)
            penaltyVal = penaltyVal + equipmentPenalty
            self.lblPenaltyAmnt.text = String(penaltyVal) + "AED"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCaptureImageSceneSegue:Safety" {
            let vc = segue.destination as! CaptureImageViewController
            vc.attendanceResponse = self.attendanceResponse
            vc.selSiteModel = self.selSiteModel
            vc.penaltyRef = String(self.penaltyVal)
        }
    }
}
