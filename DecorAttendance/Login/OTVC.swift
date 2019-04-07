//
//  OTVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 4/7/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class OTVC: UIViewController {
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var forgotPasswordResponse:ForgotPasswordResponseModel?
    var verifyOTPRequestModel = VerifyOTPRequestModel()
    var loginResponse:LoginResponseModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        addingShadowToView(view: otpTextField)
        addingRedShadowToView(view: submitButton)
        // Do any additional setup after loading the view.
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
            callVerifyOTPApi()
        }
    }
    
    func isValid()->Bool{
        var valid = true
        if otpTextField.text?.count == 0{
            valid = false
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "Enter OTP from your mail !", parentController: self)
        }
        return valid
    }
    
    func callVerifyOTPApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        verifyOTPRequestModel.clientId = self.otpTextField.text ?? ""
        verifyOTPRequestModel.resetSecret =  self.forgotPasswordResponse?.resetSecret ?? ""
        UserManager().callVerifyOTPApi(with: verifyOTPRequestModel.getRequestBody(), success: {
            (model,response)  in
           
            if let _model = model as? LoginResponseModel{
                if _model.error == 0{
                    self.loginResponse = _model
                    self.processAPIResponse()
                    self.callChangePwdApi()
                }
                else{
                    MBProgressHUD.hide(for: self.view, animated: true)
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
    
    func processAPIResponse() {
        if let _loginResponse = self.loginResponse{
            UserDefaults.standard.setValue(_loginResponse.token, forKey: "accessToken")
        }
    }
    
    func callChangePwdApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let changePasswordModel = ChangePwdRequestModel()
        changePasswordModel.new = self.verifyOTPRequestModel.password
        UserManager().callChangePasswordApi(with: changePasswordModel.getRequestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _model = model as? ChangePasswordModel{
                let type:StatusEnum = CCUtility.getErrorTypeFromStatusCode(errorValue: response.statusCode)
                if type == StatusEnum.success{
                    CCUtility.showDefaultAlertwithCompletionHandler(_title: Constant.AppName, _message: "Your password has been changed successfully", parentController: self, completion: { (status) in
                        if status{
                           self.dismiss(animated: true, completion: nil)
                        }
                    })
                }
                else if type == StatusEnum.sessionexpired{
                }
                else{
                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "Something went wrong. Please try again", parentController: self)
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

extension OTVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
