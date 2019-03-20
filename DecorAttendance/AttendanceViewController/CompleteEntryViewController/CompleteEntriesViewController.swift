//
//  CompleteEntriesViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 20/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class CompleteEntriesViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tableViewCompleteEntry: UITableView!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    
    var activeTextField: UITextField!
    var completedEntriesResponseModel:ObeidAttendanceResponseModel?
    var attendanceRequest = ObeidAttendanceRequestModel()
    @IBOutlet weak var emptyView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldSearch.delegate = self
        self.navigationItem.backBarButtonItem?.title = ""
        setViewStyles()
        addTapgesturesToView()
        self.txtFldSearch.text = ""
        initialisation()
        callFetchAttendanceaAPI()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
        attendanceRequest.isAttendanceCompleteEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func addTapgesturesToView()  {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CompleteEntriesViewController.dismissKeyBoard))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    @objc func dismissKeyBoard()  {
        if activeTextField != nil{
            activeTextField.resignFirstResponder()
        }
    }
    
    func callFetchAttendanceaAPI()  {
        ObeidiModelFetchAttendance.callfetchAtendanceRequset(requestBody:attendanceRequest.getRequestBody()){
            (success, result, error) in
            if success! && result != nil {
                if let res = result as? NSDictionary{
                    self.completedEntriesResponseModel = ObeidAttendanceResponseModel.init(dictionaryDetails: res)
                    if let response = self.completedEntriesResponseModel{
                        if (response.attendanceResultArray.count == 0){
                            self.emptyView.isHidden = false
                            self.tableViewCompleteEntry.isHidden = true
                        }
                        else{
                            self.emptyView.isHidden = true
                            self.tableViewCompleteEntry.isHidden = false
                        }
                    }
                    self.tableViewCompleteEntry.reloadData()
                }
                
            }else{
            }
        }
    }
    
    @IBAction func bttnActnSearch(_ sender: Any) {
        self.view.endEditing(true)
        if let searchText = txtFldSearch.text{
            attendanceRequest.searchText = searchText
        }
        callFetchAttendanceaAPI()
    }
    
}

extension CompleteEntriesViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let attendanceRes = self.completedEntriesResponseModel{
            return attendanceRes.attendanceResultArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCompleteEntry", for: indexPath) as! CompleteEntryTableViewCell
        if let attendanceRes = self.completedEntriesResponseModel{
            cell.setCellContents(cellData: attendanceRes.attendanceResultArray[indexPath.row])
        }
        cell.bttnDetails.tag = indexPath.row
        cell.parentViewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}
