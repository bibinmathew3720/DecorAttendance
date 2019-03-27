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
    
    var isAllButtonChecked: Bool!
    var penaltyVal: CGFloat = 0.0
    var spinner = UIActivityIndicatorView(style: .gray)
    var penaltyFullValue: CGFloat = 0.0
    
    var selSiteModel:ObeidiModelSites?
    var attendanceResponse:ObeidiModelFetchAttendance?
    var attendanceType:AttendanceType?
    var selLocation:Location?
    
    var safetyEquipmentsResponseModel:SafetyEquipmentsResponseModel?
    var selSafetyEquipments = [SafetyEquipment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        self.tableViewPenalty.delegate = self
        self.tableViewPenalty.dataSource = self
        setViewStyles()
        callSafetyEquipmentsAPI()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
        isAllButtonChecked = false
        self.title = Constant.PageNames.Attendance
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
    }
    
    func setViewStyles() {
        let layer = self.bttnNext!
        layer.layer.cornerRadius = 25
        layer.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        layer.layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        layer.layer.shadowOpacity = 1
        layer.layer.shadowRadius = 23
        
        bttnCheckAll.layer.borderWidth = 1
        bttnCheckAll.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
    }

    @IBAction func bttnActnNext(_ sender: Any) {
        self.performSegue(withIdentifier: "toCaptureImageSceneSegue:Safety", sender: Any.self)
    }
    
    func updatePenaltyValue(val: Int) {
        let valStr = String(val)
        self.lblPenaltyAmnt.text = valStr + " AED"
    }
    
    @IBAction func bttnActnCheckAll(_ sender: Any) {
        isAllButtonChecked = !isAllButtonChecked
        if isAllButtonChecked{
            self.bttnCheckAll.setImage(UIImage(named: "tick"), for: .normal)
            penaltyVal = 0
            self.lblPenaltyAmnt.text = "AED \(penaltyVal)"
            self.selSafetyEquipments.removeAll()
            if let safetyEquipments = self.safetyEquipmentsResponseModel{
                self.selSafetyEquipments.append(contentsOf: safetyEquipments.SafetyEquipments)
            }
            self.tableViewPenalty.reloadData()
        }else{
            self.bttnCheckAll.setImage(UIImage(named: ""), for: .normal)
            //update the checked status in each cell
            penaltyVal = penaltyFullValue
            self.lblPenaltyAmnt.text = "AED \(penaltyFullValue)"
            self.selSafetyEquipments.removeAll()
            self.tableViewPenalty.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let safetyResponse = self.safetyEquipmentsResponseModel{
            return safetyResponse.SafetyEquipments.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSafetyEquipmentTableView", for: indexPath) as! SafetyEquipmentsTableViewCell
        cell.bttnCheck.tag = indexPath.row
        if let equipmentRes = self.safetyEquipmentsResponseModel {
            let equipment = equipmentRes.SafetyEquipments[indexPath.row]
            cell.setCellContents(equipment: equipment, isAllChecked: self.isAllButtonChecked)
        }
        cell.checkButtonDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 105
        
    }
    
    func callSafetyEquipmentsAPI() {
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        ObeidiModelSafetyEquipments.callSafetyEquipmentsRequest() {
            (success, result, error) in
            if success! {
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                if let model = result{
                    self.safetyEquipmentsResponseModel = SafetyEquipmentsResponseModel.init(dict:model)
                    self.processData()
                }
            }else{
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            }
        }
    }
    
    func processData(){
        self.tableViewPenalty.reloadData()
        if let response = self.safetyEquipmentsResponseModel{
            var totalPenalty:CGFloat = 0.0
            for equipment in response.SafetyEquipments{
               totalPenalty = totalPenalty + equipment.penalty
            }
            penaltyVal = totalPenalty
            penaltyFullValue = totalPenalty
            self.lblPenaltyAmnt.text = "AED \(penaltyFullValue)"
        }
    }
    
    func buttonCheckedStatus(isChecked: Bool, buttonIndex: Int) {
        if let safetyResponse = self.safetyEquipmentsResponseModel{
            let equipment = safetyResponse.SafetyEquipments[buttonIndex]
            if isChecked{
                var equipmentPenalty:CGFloat = 0.0
                equipmentPenalty = safetyResponse.SafetyEquipments[buttonIndex].penalty
                penaltyVal = penaltyVal - equipmentPenalty
                self.lblPenaltyAmnt.text = "AED \(penaltyVal)"
                if !selSafetyEquipments.contains(equipment){
                    selSafetyEquipments.append(equipment)
                }
            }else{
                var equipmentPenalty:CGFloat = 0.0
                self.isAllButtonChecked = false
                self.bttnCheckAll.setImage(UIImage(named: ""), for: .normal)
                equipmentPenalty = safetyResponse.SafetyEquipments[buttonIndex].penalty
                penaltyVal = penaltyVal + equipmentPenalty
                self.lblPenaltyAmnt.text = "AED \(penaltyVal)"
                if selSafetyEquipments.contains(equipment){
                    let index = selSafetyEquipments.index(where: {$0 == equipment})
                    if let ind = index{
                        selSafetyEquipments.remove(at: ind)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCaptureImageSceneSegue:Safety" {
            let vc = segue.destination as! CaptureImageViewController
            vc.attendanceResponse = self.attendanceResponse
            vc.selSiteModel = self.selSiteModel
            vc.attendanceType = self.attendanceType
            vc.penaltyValue = self.penaltyVal
            if let safetyResponse = self.safetyEquipmentsResponseModel{
                let parentSet = Set(safetyResponse.SafetyEquipments)
                let childSet = Set(self.selSafetyEquipments)
                vc.missedSafetyEquipments = Array(parentSet.symmetricDifference(childSet))
            }
            vc.selLocation = self.selLocation
        }
    }
}
