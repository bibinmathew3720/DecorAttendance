//
//  LoginViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 15/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var txtFldUserName: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var bttnLogin: UIButton!
    @IBOutlet weak var bttnForgotPasswd: UIButton!
    @IBOutlet weak var lblLogin: UILabel!
    
    var window: UIWindow?
    var activeTextField:UITextField!
    var isForeman: Bool!
    var isSiteEngineer: Bool!
    var spinner = UIActivityIndicatorView(style: .gray)
    
    enum TextFldEntryStatus {
        
        case BothOk
        case BothNull
        case PasswordNull
        case UserNameNull
        
    }
    var textFldCurrentEntryStatus: TextFldEntryStatus!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.txtFldUserName.delegate = self
        self.txtFldPassword.delegate = self
        setUpViewStyles()
        
        self.txtFldUserName.text = "enghead"
        self.txtFldPassword.text = "123456"
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        
        case 0:
            return self.view.frame.size.height * 0.46
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
        
        self.txtFldUserName.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 18, y: 18, width: 20, height: 20))
        let image = UIImage(named: "username")
        imageView.image = image
        self.txtFldUserName.addSubview(imageView)
        
        
        self.txtFldUserName.layer.cornerRadius = 25.5
        self.txtFldUserName.backgroundColor = UIColor.white
        self.txtFldUserName.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.txtFldUserName.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.txtFldUserName.layer.shadowOpacity = 0.7
        self.txtFldUserName.layer.shadowRadius = 5
        
        self.txtFldPassword.leftViewMode = UITextField.ViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 18, y: 18, width: 20, height: 20))
        let image2 = UIImage(named: "password")
        imageView2.image = image2
        self.txtFldPassword.addSubview(imageView2)
        
        
        self.txtFldPassword.layer.cornerRadius = 25.5
        self.txtFldPassword.backgroundColor = UIColor.white
        self.txtFldPassword.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.txtFldPassword.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.txtFldPassword.layer.shadowOpacity = 0.7
        self.txtFldPassword.layer.shadowRadius = 5
        
        let backgroundImage = UIImage(named: "bg")
        let imageViewbg = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageViewbg
        

        self.bttnLogin.layer.cornerRadius = 23.5
        self.bttnLogin.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        self.bttnLogin.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.bttnLogin.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        self.bttnLogin.layer.shadowOpacity = 0.7
        self.bttnLogin.layer.shadowRadius = 5
        
        
    }
    
    @IBAction func bttnActnLogin(_ sender: Any) {
        
        ObeidiSpinner.showSpinner(self.view, activityView: self.spinner)
        if checkIfTextFieldsNull() == false {
            
            ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            callLoginAPI()
            
        }else{
            
            ObeidiSpinner.hideSpinner(self.view, activityView: self.spinner)
            switch textFldCurrentEntryStatus! {
            case .BothNull :
                print("both null")
                let missingMessage = "Both fields are needed."
                self.showAlert(alertMessage: missingMessage)
                
            case .PasswordNull :
                print("password null")
                let missingMessage = "Password required"
                self.showAlert(alertMessage: missingMessage)
                
            case .UserNameNull :
                print("username null")
                let missingMessage = "Username required"
                self.showAlert(alertMessage: missingMessage)
                
            default:
                break
                
            }

            
            
        }
//        if txtFldUserName.text == "hani" && txtFldPassword.text == "hani"{
//
//            isSiteEngineer = true
//            isForeman = false
//            self.performSegue(withIdentifier: "toHomeSceneSegue", sender: Any.self)
//
//
//        }else if txtFldUserName.text == "foreman" && txtFldPassword.text == "foreman"{
//
//            isSiteEngineer = false
//            isForeman = true
//            self.performSegue(withIdentifier: "toForemanSceneSegue:Login", sender: Any.self)
//
//        }
//
//        else{
//
//            print("error in credentials")
//            let alertController = UIAlertController(title: "Alert", message: "Error in credentials.", preferredStyle: .alert)
//
//            let actionDest = UIAlertAction(title: "Cancel", style: .destructive) { (action:UIAlertAction) in
//
//            }
//            alertController.addAction(actionDest)
//            self.present(alertController, animated: true, completion: nil)
//
//
//        }
        
        
        
    }
    func callLoginAPI() {
        
        let passDict = NSMutableDictionary()
        passDict.setValue(self.txtFldUserName.text, forKey: "username")
        passDict.setValue(self.txtFldPassword.text, forKey: "password")

        
        ObeidiModelLogin.callLoginRequest(bodyDict: passDict) {
            (success, result, error) in
            
            if(success!){
                
                print(result!)
                self.processAPIResponse(apiResponse: result)
                
                
                
            }else if success == false &&  result != nil && error == nil{
                
                let responseDict = result as! NSDictionary
                let message = responseDict.value(forKey: "message") as! String
                
                self.showAlert(alertMessage: message)
                
            }else{
                
                self.showAlert(alertMessage: (error?.localizedDescription)!)
                
            }
            
            
            
            
        }
        
        
    }
    func processAPIResponse(apiResponse: AnyObject!) {
        
        let dataDict = apiResponse as! NSDictionary
        
        let accessToken = dataDict.value(forKey: "token") as! String
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(true, forKey: Constant.VariableNames.isLoggedIn)
        
        let role = dataDict.value(forKey: "roles") as! NSArray
        
        if role.object(at: 0) as! String == "engineering-head"{
            UserDefaults.standard.setValue("Engineering Head", forKey: "role")
            self.isSiteEngineer = true
            self.isForeman = false
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.initWindow()
           // self.performSegue(withIdentifier: "toHomeSceneSegue", sender: Any.self)
            
        }else if (role.object(at: 0) as! String == "foreman"){
            UserDefaults.standard.setValue("Foreman", forKey: "role")
            self.isSiteEngineer = false
            self.isForeman = true
            self.performSegue(withIdentifier: "toForemanSceneSegue:Login", sender: Any.self)
            
        }
        
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
        
        if (isForeman != nil && isSiteEngineer != nil){
            
            if isSiteEngineer{
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let containerViewController = ContainerViewController()
            containerViewController.navigationController?.navigationBar.backgroundColor = ObeidiColors.ColorCode.obeidiRed()
                self.window!.rootViewController = containerViewController
                //self.window!.makeKeyAndVisible()
                
            }else{
                self.window = UIWindow(frame: UIScreen.main.bounds)
                
                let containerViewControllerForeman = ForemanContainerViewController()
                containerViewControllerForeman.navigationController?.navigationBar.backgroundColor = ObeidiColors.ColorCode.obeidiRed()
                
                self.window!.rootViewController = containerViewControllerForeman
                self.window!.makeKeyAndVisible()
            }
        }
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
    
    @IBAction func bttnActnForgotPassword(_ sender: Any){
        
        self.performSegue(withIdentifier: "toForgotPasswordSceneSegue:Login", sender: Any.self)
        
        
        
        
    }
    func checkIfTextFieldsNull() -> Bool   {
        
        if self.txtFldUserName.text == "" && self.txtFldPassword.text == ""{
            self.textFldCurrentEntryStatus = TextFldEntryStatus.BothNull
            return true
            
        }else if(self.txtFldUserName.text == ""){
            self.textFldCurrentEntryStatus = TextFldEntryStatus.UserNameNull
            return true
            
        }else if(self.txtFldPassword.text == ""){
            self.textFldCurrentEntryStatus = TextFldEntryStatus.PasswordNull
            return true
            
        }else{
            self.textFldCurrentEntryStatus = TextFldEntryStatus.BothOk
            return false
            
        }
        
        
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
