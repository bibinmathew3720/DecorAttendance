//
//  ReportListingTVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/21/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ReportListingTVC: UITableViewCell {
    @IBOutlet weak var labourImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var markedAtLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var overTimeLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
        // Initialization code
    }
    
    func customisation(){
       detailButton.setRoundedRedBackgroundView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func detailButtonAction(_ sender: UIButton) {
    }
    
}
