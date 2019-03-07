//
//  CalenderViewCell.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 13/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit
import JTAppleCalendar


class CalenderViewCell: JTAppleCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var viewSelected: UIView!

    override func awakeFromNib() {
        
        self.viewSelected.layer.cornerRadius =
        20.0
        self.viewSelected.bringSubviewToFront(dateLabel)
        self.viewSelected.backgroundColor = ObeidiColors.ColorCode.obeidiButtonAsh()
    
        
        
    }

}
