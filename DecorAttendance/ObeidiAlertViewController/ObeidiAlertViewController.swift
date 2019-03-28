//
//  ObiediAlertViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 28/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

protocol dismissDelegate: class {
    
    func dismissed()
}

class ObeidiAlertViewController: UIViewController {

    @IBOutlet weak var viewAlertContainer: UIView!
    @IBOutlet weak var imageViewTop: UIImageView!
   
    @IBOutlet weak var bttnOK: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblExplained: UILabel!
    
    @IBOutlet weak var bttnLogout: UIButton!
    
    var titleRef: String!
    var explanationRef: String!
    var parentController: UIViewController!
    weak var delegate: dismissDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setViewStyles()
        // Do any additional setup after loading the view.
    }
    
    func setViewStyles()  {
        
        self.view.backgroundColor = .clear
        
        self.bttnOK.layer.cornerRadius = self.bttnOK.frame.size.height / 2
        self.bttnOK.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        
        self.bttnLogout.layer.cornerRadius = self.bttnLogout.frame.size.height / 2
        self.bttnLogout.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        
        
        self.viewAlertContainer.layer.cornerRadius = 5
        self.viewAlertContainer.backgroundColor = UIColor.white
        self.viewAlertContainer.layer.shadowOffset = CGSize(width: 0, height: 18)
        self.viewAlertContainer.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        self.viewAlertContainer.layer.shadowOpacity = 1
        self.viewAlertContainer.layer.shadowRadius = 18
        self.lblExplained.text = explanationRef
        self.lblTitle.text = titleRef
    }
    

    @IBAction func bttnActnOK(_ sender: Any) {
        delegate?.dismissed()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bttnActnLogOut(_ sender: Any) {
        CCUtility.processAfterLogOut()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.initWindow()
    }
    
    
}
