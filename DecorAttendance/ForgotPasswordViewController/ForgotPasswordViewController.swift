//
//  ForgotPasswordViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 11/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var lblResetPassword: UILabel!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldNewPasswd: UITextField!
    @IBOutlet weak var txtFldConfrmPasswd: UITextField!
    @IBOutlet weak var bttnSubmit: UIButton!
    
    @IBOutlet weak var bttnLoginNow: UIButton!
    
    var window: UIWindow?
    var activeTextField:UITextField!
    var isForeman: Bool!
    var isSiteEngineer: Bool!
    var resetSecret: String!
    var clientID: String!
    
    enum TextFldEntryStatus {
        
        case AllOk
        case AllNull
        case PasswordNull
        case EmailNull
        case ConfirmPasswordNull
        case EmailPasswdNull
        case EmailCnfrmNull
        case passwdCnfrmNull
        
    }
    var textFldCurrentEntryStatus: TextFldEntryStatus!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtFldEmail.delegate = self
        self.txtFldNewPasswd.delegate = self
        self.txtFldConfrmPasswd.delegate = self
        self.setUpViewStyles()
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return self.view.frame.size.height * 0.36
        default:
            return 80
            
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
    
    func setUpViewStyles(){
        
        self.txtFldEmail.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 18, y: 18, width: 20, height: 20))
        let image = UIImage(named: "username")
        imageView.image = image
        self.txtFldEmail.addSubview(imageView)
        
        
        self.txtFldEmail.layer.cornerRadius = 25.5
        self.txtFldEmail.backgroundColor = UIColor.white
        self.txtFldEmail.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.txtFldEmail.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.txtFldEmail.layer.shadowOpacity = 0.7
        self.txtFldEmail.layer.shadowRadius = 5
        
        self.txtFldNewPasswd.leftViewMode = UITextField.ViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 18, y: 18, width: 20, height: 20))
        let image2 = UIImage(named: "password")
        imageView2.image = image2
        self.txtFldNewPasswd.addSubview(imageView2)
        
        
        self.txtFldNewPasswd.layer.cornerRadius = 25.5
        self.txtFldNewPasswd.backgroundColor = UIColor.white
        self.txtFldNewPasswd.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.txtFldNewPasswd.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.txtFldNewPasswd.layer.shadowOpacity = 0.7
        self.txtFldNewPasswd.layer.shadowRadius = 5
        
        self.txtFldConfrmPasswd.leftViewMode = UITextField.ViewMode.always
        let imageView3 = UIImageView(frame: CGRect(x: 18, y: 18, width: 20, height: 20))
        let image3 = UIImage(named: "password")
        imageView3.image = image3
        self.txtFldConfrmPasswd.addSubview(imageView3)
        
        
        self.txtFldConfrmPasswd.layer.cornerRadius = 25.5
        self.txtFldConfrmPasswd.backgroundColor = UIColor.white
        self.txtFldConfrmPasswd.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.txtFldConfrmPasswd.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.txtFldConfrmPasswd.layer.shadowOpacity = 0.7
        self.txtFldConfrmPasswd.layer.shadowRadius = 5
        
        let backgroundImage = UIImage(named: "bg")
        let imageViewbg = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageViewbg
        
        
        self.bttnSubmit.layer.cornerRadius = 23.5
        self.bttnSubmit.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        self.bttnSubmit.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.bttnSubmit.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        self.bttnSubmit.layer.shadowOpacity = 0.7
        self.bttnSubmit.layer.shadowRadius = 5
        
        
    }
    
    @IBAction func bttnActnSubmit(_ sender: Any) {
        
        if !isNullValuePresent(){
            
            if !isPasswordsMismatching(){
                
                callForgotPassWordAPI()
                
            }else{
                
                let message = "Passwords mismatching"
                self.showAlert(alertMessage: message)
            }
            
            
        }else{
            //ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            switch textFldCurrentEntryStatus! {
            case .AllNull :
                print("both null")
                let missingMessage = "All fields are needed."
                self.showAlert(alertMessage: missingMessage)
                
            case .PasswordNull :
                print("password null")
                let missingMessage = "Password required"
                self.showAlert(alertMessage: missingMessage)
                
            case .EmailNull :
                print("username null")
                let missingMessage = "Email required"
                self.showAlert(alertMessage: missingMessage)
            case .passwdCnfrmNull :
                let missingMessage = "password and Confirm-password required"
                self.showAlert(alertMessage: missingMessage)
            case .EmailPasswdNull :
                let missingMessage = "email and password required"
                self.showAlert(alertMessage: missingMessage)
            case .EmailCnfrmNull :
                let missingMessage = "email and confirm password required"
                self.showAlert(alertMessage: missingMessage)
            case .ConfirmPasswordNull :
                let missingMessage = "confirm password required"
                self.showAlert(alertMessage: missingMessage)
            case .AllOk:
                break
                
            }

            
            
        }

        
    }
    func isNullValuePresent() -> Bool {
        
        if self.txtFldEmail.text == "" && self.txtFldNewPasswd.text == "" && self.txtFldConfrmPasswd.text == "" {
            self.textFldCurrentEntryStatus = TextFldEntryStatus.AllNull
            return true
            
        }else if self.txtFldEmail.text == "" && self.txtFldNewPasswd.text == "" {
            self.textFldCurrentEntryStatus = TextFldEntryStatus.EmailPasswdNull
            return true
            
        }else if self.txtFldEmail.text == "" && self.txtFldConfrmPasswd.text == "" {
            self.textFldCurrentEntryStatus = TextFldEntryStatus.EmailCnfrmNull
            return true
            
        }else if self.txtFldNewPasswd.text == "" && self.txtFldConfrmPasswd.text == "" {
            self.textFldCurrentEntryStatus = TextFldEntryStatus.passwdCnfrmNull
            return true
            
        }
        else if(self.txtFldEmail.text == ""){
            self.textFldCurrentEntryStatus = TextFldEntryStatus.EmailNull
            return true
            
        }else if(self.txtFldNewPasswd.text == ""){
            self.textFldCurrentEntryStatus = TextFldEntryStatus.PasswordNull
            return true
            
        }else if(self.txtFldConfrmPasswd.text == ""){
            self.textFldCurrentEntryStatus = TextFldEntryStatus.ConfirmPasswordNull
            return true
            
        }else{
            self.textFldCurrentEntryStatus = TextFldEntryStatus.AllOk
            return false
            
        }
        
        
    }
    func isPasswordsMismatching() -> Bool {
        
        if self.textFldCurrentEntryStatus == TextFldEntryStatus.AllOk {
            
            if self.txtFldConfrmPasswd.text == self.txtFldNewPasswd.text{
                
                return false
            }
            return true
            
        }
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toHomeSceneSegue"{
            
            
        }
        else if segue.identifier == "toForemanScenesSegue:Login" {
            
            //let storyBoard = UIStoryboard(name: "Foreman", bundle: Bundle.main)
            //_ = storyBoard.instantiateViewController(withIdentifier: "TestViewControllerID") as! TestViewController
            
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
//        if isSiteEngineer{
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//
//            let containerViewController = ContainerViewController()
//            containerViewController.navigationController?.navigationBar.backgroundColor = ObeidiColors.ColorCode.obeidiRed()
//
//            self.window!.rootViewController = containerViewController
//            self.window!.makeKeyAndVisible()
//
//        }else{
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//
//            let containerViewControllerForeman = ForemanContainerViewController()
//            containerViewControllerForeman.navigationController?.navigationBar.backgroundColor = ObeidiColors.ColorCode.obeidiRed()
//
//            self.window!.rootViewController = containerViewControllerForeman
//            self.window!.makeKeyAndVisible()
//
//
//        }
        
    }
    
    func addTapgesturesToView()  {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyBoard))
        
        self.view.addGestureRecognizer(tapGesture)
        
    }
    @objc func dismissKeyBoard()  {
        
        if activeTextField != nil{
            
            activeTextField.resignFirstResponder()
            
        }
        
        
    }

    func callForgotPassWordAPI(){
        
        ObeidiModelForgotPassword.callForgotPasswordRequest(email: self.txtFldEmail.text!) {
            (success, result, error) in
            
            if success!{
                if result != nil{
                    
                    let dict = result as! NSDictionary
                    self.resetSecret = (dict.value(forKey: "reset_secret") as! String)
                    self.clientID = (dict.value(forKey: "client_id") as! String)
                    
                    
                }
                
            }else{
                
                
                print("error")
            }
            
            
        }
        
    }
    func callAccessTokenAPI() {
        
    }

    
    @IBAction func bttnActnLoginNow(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    func showAlert(alertMessage: String) {
        
        self.view.alpha = 0.65
        let alertData = alertMessage
        let alert = UIAlertController(title: "Alert", message: alertData, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { action in
            self.view.alpha = 1.0
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}
