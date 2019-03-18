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
    
    @IBOutlet weak var BgImage: UIImageView!
     @IBOutlet weak var messageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        // Do any additional setup after loading the view.
    }
    func initialisation(){
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

}
