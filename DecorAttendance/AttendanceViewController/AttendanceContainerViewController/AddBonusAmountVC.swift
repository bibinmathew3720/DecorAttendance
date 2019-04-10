//
//  AddBonusAmountVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 4/8/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class AddBonusAmountVC: UIViewController {
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var addBonusTF: UITextField!
    var selectedSite: ObeidiModelSites?
    var attendanceDetails:ObeidiModelFetchAttendance?
    var updateBonusRequest = UpdateBonusAmountRequestModel()
    var attendanceId:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()

        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
        addingRedShadowToView(view: submitButton)
        addingShadowToView(view: addBonusTF)
        dataPopulation()
    }
    
    func dataPopulation(){
        if let attendanceRes = self.attendanceDetails{
            self.addBonusTF.text = "\(attendanceRes.bonusAmount)"
            if let attId = attendanceId{
                updateBonusRequest.attendanceId = attId
            }
        }
    }
    
    func addingShadowToView(view:UIView){
        view.layer.cornerRadius = 25.5
        view.backgroundColor = UIColor.white
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 5
    }
    
    func addingRedShadowToView(view:UIView){
        view.layer.cornerRadius = 23.5
        view.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 5
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if isValid(){
            callingAddBonusAmountApi()
        }
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func isValid()->Bool{
        var valid = true
        if let bonusText = addBonusTF.text{
            if let bonusValue = Float (bonusText){
                let bonusValueCGFloat = CGFloat(bonusValue)
                print(bonusValueCGFloat)
                if let selSite = self.selectedSite{
                    if bonusValueCGFloat > selSite.remainingBonusNew{
                        valid = false
                        CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "Entered bonus amount greater than available bonus point", parentController: self)
                    }
                }
            }
        }
        return valid
    }
    
    func callingAddBonusAmountApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if let bonusAmountString = self.addBonusTF.text{
            updateBonusRequest.bonus = bonusAmountString
        }
        LabourManager().updateBonusAmountApi(with: updateBonusRequest.getRequestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _model = model as? UpdateBonusAmountResponseModel{
                if _model.error == 0{
                    CCUtility.showDefaultAlertwithCompletionHandler(_title: Constant.AppName, _message: "Bonus Amount Updated Successfully", parentController: self, completion: { (status) in
                        if status {
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                }
                else{
                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: _model.message, parentController: self)
                }
            }
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: User.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: User.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            print(ErrorType)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension AddBonusAmountVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
