//
//  EmployeeViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 19/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate {
    

    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var tableViewEmployee: UITableView!
    @IBOutlet weak var emptyView: UIView!
    var selectedIndex:Int = -1
    var activeTextField: UITextField!
    var employeeResponse:DecoreEmployeeResponseModel?
    var employeeRequest = EmployeesRequestModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        getEmployeesApi()
        addTapgesturesToView()
        
        txtFldSearch.delegate = self
        self.tableViewEmployee.delegate = self
        self.tableViewEmployee.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        
        setViewStyle()

        // Do any additional setup after loading the view.
    }
    
    //Search Button Action
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        if let searchText = self.txtFldSearch.text{
            employeeRequest.searchText = searchText
            self.view.endEditing(true)
            getEmployeesApi()
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: tableViewEmployee))!{
            
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.employeeResponse{
            return model.employees.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEmployee", for: indexPath) as! EmployeeTableViewCell
        if let model = self.employeeResponse{
            if model.employees.count > 0{
            cell.setCell(model: model.employees[indexPath.row], imageBase: model.image_base)
            }
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 87
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "toEmployeeDetailsSceneSegue:Employee", sender: Any.self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toEmployeeDetailsSceneSegue:Employee") {
            let vc = segue.destination as! EmployeeDetailsViewController
            if let model = self.employeeResponse?.employees{
                vc.details = model[selectedIndex]
                vc.imageBase = self.employeeResponse?.image_base
            }
        }
    }
    
    //MARK: textfield delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        
    }
    
    func setViewStyle() {
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EmployeeViewController.dismissKeyBoard))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyBoard()  {
        if activeTextField != nil{
            activeTextField.resignFirstResponder()
        }
    }

    func getEmployeesApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().getEmployeesApi(with:employeeRequest.getReqestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? DecoreEmployeeResponseModel{
                let type:StatusEnum = CCUtility.getErrorTypeFromStatusCode(errorValue: response.statusCode)
                if type == StatusEnum.success{
                    self.employeeResponse = model
                    if (model.employees.count == 0){
                       self.tableViewEmployee.isHidden = true
                        if let empView = self.emptyView{
                            empView.isHidden = false
                        }
                    }
                    else{
                        self.tableViewEmployee.isHidden = false
                        if let empView = self.emptyView{
                            empView.isHidden = true
                        }
                    }
                    self.tableViewEmployee.reloadData()
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
}
