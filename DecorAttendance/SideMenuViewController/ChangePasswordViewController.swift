//
//  ChangePasswordViewController.swift
//  DecorAttendance
//
//  Created by Nimmy K Das on 3/15/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var submitButton: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var currentPwdTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewStyles()
    }
    
    func setUpViewStyles(){
        
        self.confirmPasswordTF.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 18, y: 18, width: 20, height: 20))
        let image = UIImage(named: "password")
        imageView.image = image
        self.confirmPasswordTF.addSubview(imageView)
        
        
        self.confirmPasswordTF.layer.cornerRadius = 25.5
        self.confirmPasswordTF.backgroundColor = UIColor.white
        self.confirmPasswordTF.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.confirmPasswordTF.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.34).cgColor
        self.confirmPasswordTF.layer.shadowOpacity = 0.7
        self.confirmPasswordTF.layer.shadowRadius = 5
        
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
        
        let backgroundImage = UIImage(named: "bg")
        let imageViewbg = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageViewbg
        
        
        self.submitButton.layer.cornerRadius = 23.5
        self.submitButton.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        self.submitButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.submitButton.layer.shadowColor = UIColor(red:0.11, green:0.16, blue:0.36, alpha:0.62).cgColor
        self.submitButton.layer.shadowOpacity = 0.7
        self.submitButton.layer.shadowRadius = 5
        
        
    }
    

}
