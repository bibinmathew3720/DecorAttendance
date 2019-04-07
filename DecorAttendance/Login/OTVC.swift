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
        UserManager().callVerifyOTPApi(with: verifyOTPRequestModel.getRequestBody(), success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _model = model as? VerifyOTPResponseModel{
                if _model.error == 0{
                    
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
