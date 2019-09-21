//
//  MedicalLeaveTVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/21/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class MedicalLeaveTVC: UITableViewCell {
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
        // Initialization code
    }
    
    func customisation(){
        statusButton.setRoundedRedBorder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMedicalLeave(medicalLeave:MedicalLeave){
        startDateLabel.text = medicalLeave.startDate
        endDateLabel.text = medicalLeave.endDate
        if medicalLeave.isApproved == 1{
            statusButton.setTitle("APPROVED", for: .normal)
        }
        else{
            statusButton.setTitle("DISAPPROVE", for: .normal)
        }
    }

}
