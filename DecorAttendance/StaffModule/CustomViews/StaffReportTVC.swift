//
//  StaffReportTVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/21/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class StaffReportTVC: UITableViewCell {
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var leavesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLeaveMonth(leaveMonth:LeaveMonth){
        monthLabel.text = leaveMonth.monthName
        leavesCountLabel.text = "\(leaveMonth.leaveCount) leaves in total"
    }

}
