//
//  AboutViewController.swift
//  DecorAttendance
//
//  Created by Nimmy K Das on 3/17/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var missionView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var webIDLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var visionLabel: UILabel!
    @IBOutlet weak var ceoMessageLabel: UILabel!
    @IBOutlet weak var ceoImage: UIImageView!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var BgImage: UIImageView!
     @IBOutlet weak var messageView: UIView!
    var phone: String = ""
    var mailAddress:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        getAboutApi()
        initialisation()
        // Do any additional setup after loading the view.
    }
    func initialisation(){
        self.title = Constant.PageNames.AboutUs
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        self.missionView.layer.cornerRadius = 8
        self.missionView.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.missionView.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.missionView.layer.shadowOpacity = 0.7
        self.missionView.layer.shadowRadius = 5
        
        self.messageView.layer.cornerRadius = 8
        self.messageView.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.messageView.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.messageView.layer.shadowOpacity = 0.7
        self.messageView.layer.shadowRadius = 5
        
        self.aboutView.layer.cornerRadius = 8
        self.aboutView.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.aboutView.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.aboutView.layer.shadowOpacity = 0.7
        self.aboutView.layer.shadowRadius = 5
    }
    @IBAction func mailAction(_ sender: Any) {
        if self.mailAddress != ""{
            let appURL = URL(string: "mailto:" + self.mailAddress)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.openURL(appURL as URL)
        }
        }
    }
    
    @IBAction func callAction(_ sender: Any) {
        guard let number = URL(string:"TEL://" + phone ) else { return }
        UIApplication.shared.open(number)
    }
    func getAboutApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().getAboutApi(with:"", success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? DecoreAboutResponseModel{
                let type:StatusEnum = CCUtility.getErrorTypeFromStatusCode(errorValue: response.statusCode)
                if type == StatusEnum.success{
                    self.phoneLabel.text = model.phone_number
                    self.ceoImage.loadImageUsingCache(withUrl: model.image_base + model.ceo_image, colorValue: nil)
                    self.ceoMessageLabel.text  = model.message_from_ceo
                    self.aboutLabel.text = model.about_content
                    self.visionLabel.text = model.mission_and_vision
                    self.BgImage.loadImageUsingCache(withUrl: model.image_base + model.banner_image, colorValue: nil)
                    self.webIDLabel.text = model.email
                    self.mailAddress = model.email
                    self.phone = model.phone_number
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

