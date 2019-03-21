//
//  ChangePasswordViewController.swift
//  DecorAttendance
//
//  Created by Nimmy K Das on 3/15/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var currentPwdTF: UITextField!
    var pwd = ChangePwdRequestModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewStyles()
    }
    
    @IBAction func submitAction(_ sender: Any) {
        callChangePwdApi()
    }
    
     func showAlert(alertMessage: String) {
        let alertData = alertMessage
        let alert = UIAlertController(title: "Alert", message: alertData, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func setUpViewStyles(){
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        
        self.currentPwdTF.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 18, y: 18, width: 20, height: 20))
        let image = UIImage(named: "password")
        imageView.image = image
        self.currentPwdTF.addSubview(imageView)
        
        
        self.currentPwdTF.layer.cornerRadius = 25.5
        self.currentPwdTF.backgroundColor = UIColor.white
        self.currentPwdTF.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.currentPwdTF.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.currentPwdTF.layer.shadowOpacity = 0.7
        self.currentPwdTF.layer.shadowRadius = 5
        
        self.newPasswordTF.leftViewMode = UITextField.ViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 18, y: 18, width: 20, height: 20))
        let image2 = UIImage(named: "password")
        imageView2.image = image2
        self.newPasswordTF.addSubview(imageView2)
        
        
        self.newPasswordTF.layer.cornerRadius = 25.5
        self.newPasswordTF.backgroundColor = UIColor.white
        self.newPasswordTF.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.newPasswordTF.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.newPasswordTF.layer.shadowOpacity = 0.7
        self.newPasswordTF.layer.shadowRadius = 5
        
        self.confirmPasswordTF.leftViewMode = UITextField.ViewMode.always
        let imageView3 = UIImageView(frame: CGRect(x: 18, y: 18, width: 20, height: 20))
        let image3 = UIImage(named: "password")
        imageView3.image = image3
        self.confirmPasswordTF.addSubview(imageView3)
        
        
        self.confirmPasswordTF.layer.cornerRadius = 25.5
        self.confirmPasswordTF.backgroundColor = UIColor.white
        self.confirmPasswordTF.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.confirmPasswordTF.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.confirmPasswordTF.layer.shadowOpacity = 0.7
        self.confirmPasswordTF.layer.shadowRadius = 5
        
        self.submitButton.layer.cornerRadius = 23.5
        self.submitButton.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        self.submitButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.submitButton.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        self.submitButton.layer.shadowOpacity = 0.7
        self.submitButton.layer.shadowRadius = 5
        
        
    }
    
    @IBAction func textFieldEditingChangedMethod(_ sender: UITextField) {
        if let textString = sender.text {
            if sender == currentPwdTF {
                pwd.current = textString
            }
            else if sender == newPasswordTF{
                pwd.new = textString
            }
            else if sender == confirmPasswordTF{
                pwd.confirm = textString
            }
        }
    }
    
    //MARK: Validation
    
    func isValid()->Bool {
        if !pwd.current.isValidString(){
            if !pwd.new.isValidString(){
                if pwd.new.isPassowrdValid(){
                    if !pwd.confirm.isValidString(){
                        if pwd.new == pwd.confirm{
                            return true
                        }
                        else{
                            self.showAlert(alertMessage: "Password does not match the confirm password")
                            return false
                        }
                    }
                    else{
                        self.showAlert(alertMessage: "Please confirm your password")
                        return false
                    }
                }
                else{
                     self.showAlert(alertMessage: "Your password should be at least 6 characters")
                    return false
                }
            }
            else{
               self.showAlert(alertMessage: "Please enter your new password")
                return false
            }
        }
        else{
            self.showAlert(alertMessage: "Please enter your current password")
            return false
            
        }
    }
    
    func callChangePwdApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callChangePasswordApi(with: getChangePwdRequestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _model = model as? ChangePasswordModel{
                let type:StatusEnum = CCUtility.getErrorTypeFromStatusCode(errorValue: response.statusCode)
                if type == StatusEnum.success{
                    self.showAlert(alertMessage: "Your password has been changed successfully")
                }
                else if type == StatusEnum.sessionexpired{
                }
                else{
                    self.showAlert(alertMessage: "Something went wrong. Please try again")
                }            }
            
            
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                self.showAlert(alertMessage: User.ErrorMessages.noNetworkMessage)
            }
            else{
                self.showAlert(alertMessage: User.ErrorMessages.serverErrorMessamge)
            }
            
            print(ErrorType)
        }
    }
    func getChangePwdRequestBody()->String{
        return pwd.getRequestBody()
    }
}
extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == currentPwdTF {
            newPasswordTF.becomeFirstResponder()
        }
        else if (textField == newPasswordTF){
            confirmPasswordTF.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        return true
    }
    
}
