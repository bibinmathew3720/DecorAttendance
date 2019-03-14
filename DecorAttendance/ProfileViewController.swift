//
//  ProfileViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 04/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var employeeID: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewWorkInfo: UIView!
    @IBOutlet weak var viewProfilePic: UIView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var siteLabel: UILabel!
    var profileResponse: DecoreProfileResponseModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileApi()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        setViewStyles()
        
    }

   
    
    func getProfileApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().getProfileApi(with:"", success: {
            (model,response)  in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? DecoreProfileResponseModel{
                let type:StatusEnum = CCUtility.getErrorTypeFromStatusCode(errorValue: response.statusCode)
                if type == StatusEnum.success{
                    self.profileResponse = model
                    self.imageViewProfile.loadImageUsingCache(withUrl: model.image, colorValue: nil)
                    self.nameLabel.text = model.name
                    self.employeeID.text = "Employee ID: " + String(model.emp_id)
                    self.siteLabel.text = "Site " + model.sites[0].site_name
                    self.ageLabel.text = String(CCUtility.calcAge(birthday: model.dob)) + " yr old"
                    self.designationLabel.text =  UserDefaults.standard.string(forKey: "role")
                    self.joinDateLabel.text = "Joining date: " + model.date_of_joining
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 267
        default:
            return 227
        }
        
    }
    func setViewStyles() {
        
        imageViewProfile.layer.cornerRadius = imageViewProfile.frame.size.height / 2
        imageViewProfile.clipsToBounds = true
        
        viewProfilePic.layer.cornerRadius = 5
        viewProfilePic.backgroundColor = UIColor.white
        viewProfilePic.layer.shadowOffset = CGSize(width: 0, height: 5)
        viewProfilePic.layer.shadowColor = UIColor(red:0.46, green:0.56, blue:0.59, alpha:0.41).cgColor
        viewProfilePic.layer.shadowOpacity = 1
        viewProfilePic.layer.shadowRadius = 14
        
        viewWorkInfo.layer.cornerRadius = 5
        viewWorkInfo.backgroundColor = UIColor.white
        viewWorkInfo.layer.shadowOffset = CGSize(width: 0, height: 5)
        viewWorkInfo.layer.shadowColor = UIColor(red:0.46, green:0.56, blue:0.59, alpha:0.41).cgColor
        viewWorkInfo.layer.shadowOpacity = 1
        viewWorkInfo.layer.shadowRadius = 14
       
        
    }

}
