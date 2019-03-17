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
    @IBOutlet weak var emptyView: UIView!
    
    var activeTextField: UITextField!
    var spinner = UIActivityIndicatorView(style: .gray)
    
    var labourWiseCostSummaryResponse:ObeidiModelCostSummaryLabourWise?
    var labourWiseRequestModel = LabourWiseRequestModel()
    var isApiCalling:Bool =  true
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewStyles()
        initialisation()
        addTapgesturesToView()
        callLabourWiseCostSummaryAPI()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
       resetRequestModel()
    }
    
    func resetRequestModel(){
        labourWiseRequestModel.perPage = 10
        labourWiseRequestModel.pageIndex = 0
        labourWiseRequestModel.searchText = ""
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
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if let searchText = self.txtFldSearch.text{
            resetRequestModel()
            self.labourWiseRequestModel.searchText = searchText
            callLabourWiseCostSummaryAPI()
        }
    }
    
    @objc func dismissKeyBoard()  {
        if activeTextField != nil{
            activeTextField.resignFirstResponder()
        }
    }
    
    func callLabourWiseCostSummaryAPI()  {
        self.isApiCalling = true
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
    ObeidiModelCostSummaryLabourWise.callCostSummaryRequset(requestBody:self.labourWiseRequestModel.getReqestBody()) {
            (success, result, error) in
           self.isApiCalling = false
            if success! {
                ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
                if let res = result as? ObeidiModelCostSummaryLabourWise{
                    self.labourWiseCostSummaryResponse = res
                    self.tableViewLabourwise.reloadData()
                    if (res.costSummaryArray.count == 0){
                        self.emptyView.isHidden = false
                        self.tableViewLabourwise.isHidden = true
                    }
                    else{
                        self.emptyView.isHidden = true
                        self.tableViewLabourwise.isHidden = false
                    }
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
        cell.labourCellDelegate = self
        cell.bttnDetails.tag = indexPath.row;
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let costSummaryRes = self.labourWiseCostSummaryResponse{
            if (indexPath.row == (costSummaryRes.costSummaryArray.count - 1)){
                if (!self.isApiCalling){
                    //self.labourWiseRequestModel.pageIndex = self.labourWiseRequestModel.pageIndex + 1
                    //self.callLabourWiseCostSummaryAPI()
                }
            }
        }
//        if(indexPath.row == (notificationHistoryArray.count-1)){
//            if((self.notificationModel?.total)! > (self.notificationHistoryArray.count)){
//                callingNotificationHistoryApi()
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constant.SegueIdentifiers.labourWisetoLabourSummary){
            if let destController = segue.destination as? LabourSummaryViewController{
                if let costSum = sender as? CostSummary{
                    destController.costSummary = costSum
                }
            }
        }
    }
}

extension LabourwiseViewController:LabourwiseTableViewCellDelegate{
    func detailButtonActionDelegate(button: UIButton) {
        if let costSummaryRes = self.labourWiseCostSummaryResponse{
            let costSummary = costSummaryRes.costSummaryArray[button.tag]
            self.performSegue(withIdentifier: Constant.SegueIdentifiers.labourWisetoLabourSummary, sender: costSummary)
        }
    }
}
