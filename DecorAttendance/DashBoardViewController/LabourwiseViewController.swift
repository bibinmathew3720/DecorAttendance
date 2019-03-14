//
//  LabourwiseViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 19/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class LabourwiseViewController: UIViewController {

    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var tableViewLabourwise: UITableView!
    
    var activeTextField: UITextField!
    var spinner = UIActivityIndicatorView(style: .gray)
    
    var labourWiseCostSummaryResponse:ObeidiModelCostSummaryLabourWise?
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewStyles()
        addTapgesturesToView()
        callLabourWiseCostSummaryAPI(keyword: "", startDate: "", endDate: "")
        // Do any additional setup after loading the view.
    }
    
    func setViewStyles() {
        let layer = self.viewSearchBar!
        layer.backgroundColor = UIColor.white
        layer.layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.2).cgColor
        layer.layer.shadowOpacity = 1
        layer.layer.shadowRadius = 8
        let layer1 = txtFldSearch!
        layer1.layer.cornerRadius = 3
        layer1.layer.borderWidth = 0.5
        layer1.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
    }
    
    func addTapgesturesToView()  {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LabourwiseViewController.dismissKeyBoard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyBoard()  {
        if activeTextField != nil{
            activeTextField.resignFirstResponder()
        }
    }
    
    func callLabourWiseCostSummaryAPI(keyword: String!, startDate: String!, endDate: String!)  {
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        ObeidiModelCostSummaryLabourWise.callCostSummaryRequset(keyword: keyword, startDate: startDate, endDate: endDate) {
            (success, result, error) in
            if success! {
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                if let res = result as? ObeidiModelCostSummaryLabourWise{
                    self.labourWiseCostSummaryResponse = res
                    self.tableViewLabourwise.reloadData()
                }
            }else{
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            }
        }
    }
}

extension LabourwiseViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
}

extension LabourwiseViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let costSummaryRes = self.labourWiseCostSummaryResponse{
            return costSummaryRes.costSummaryArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellLabourwise", for: indexPath) as! LabourwiseTableViewCell
        if let costSummaryRes = self.labourWiseCostSummaryResponse{
            cell.setCostSummary(costDetail:costSummaryRes.costSummaryArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
