//
//  AttendanceContainerViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 20/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class AttendanceContainerViewController: UIViewController {

    @IBOutlet weak var viewTopBar: UIView!
    @IBOutlet weak var lineIndicatorNewEntry: UIView!
    @IBOutlet weak var lineIndicatorCompleteEntry: UIView!
    @IBOutlet weak var containerViewNewEntry: UIView!
    @IBOutlet weak var containerViewCompleteEntry: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
    }
    

    @IBAction func bttnActnNewEntry(_ sender: Any) {
        
        self.containerViewNewEntry.alpha = 1.0
        self.containerViewNewEntry.isUserInteractionEnabled = true
        
        self.containerViewCompleteEntry.alpha = 0.0
        self.containerViewCompleteEntry.isUserInteractionEnabled = false
        
        lineIndicatorCompleteEntry.backgroundColor = ObeidiFont.Color.obeidiLineRed()
        lineIndicatorNewEntry.backgroundColor = ObeidiFont.Color.obeidiLineWhite()
        
    }
    
    @IBAction func bttnActnCompleteEntries(_ sender: Any) {
        
        self.containerViewNewEntry.alpha = 0.0
        self.containerViewNewEntry.isUserInteractionEnabled = false
        
        self.containerViewCompleteEntry.alpha = 1.0
        self.containerViewCompleteEntry.isUserInteractionEnabled = true
        
        lineIndicatorCompleteEntry.backgroundColor = ObeidiColors.ColorCode.obeidiLineWhite()
        lineIndicatorNewEntry.backgroundColor = ObeidiColors.ColorCode.obeidiLineRed()
        
        
    }
    
}
