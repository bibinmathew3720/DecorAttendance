//
//  ReportListingTVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/21/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

protocol ReportListingTVCDelegate {
    func detailsButtonActionAt(index:Int)
}

class ReportListingTVC: UITableViewCell {
    @IBOutlet weak var labourImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var timeLabelView: UIView!
    @IBOutlet weak var markedAtLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var overTimeLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    var delegate:ReportListingTVCDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
        // Initialization code
    }
    
    func customisation(){
       detailButton.setRoundedRedBackgroundView()
    }
    
    func setCellContents(cellData: ObeidiModelFetchAttendance)  {
        self.idLabel.text = "OAA\(cellData.empId)"
        self.nameLabel.text = cellData.name
         guard let encodedUrlstring = (cellData.profileBaseUrl.trimLeadingAndTrailingSpaces()+cellData.profileImageUrl.trimLeadingAndTrailingSpaces()).addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else { return  }
        if let imageUrl = URL(string: encodedUrlstring){
            self.labourImageView.setImageWith(imageUrl, placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
        }
        if cellData.isStrike{
            self.statusView.isHidden = false
            self.timeLabelView.isHidden = true
            
            self.statusLabel.text = "Strike"
        }
        else if !cellData.isPresent{
            self.statusView.isHidden = false
            self.timeLabelView.isHidden = true
            
            self.statusLabel.text = "Absent"
        }
        else{
            self.statusView.isHidden = true
            self.timeLabelView.isHidden = false
            
            self.markedAtLabel.text = cellData.markedAt
            self.startTimeLabel.text = cellData.startTimeMarkedAt
            if cellData.isEndTimeMarkd{
                self.endTimeLabel.text = cellData.endTimeMarkedAt
            }
            else{
                self.endTimeLabel.text = "--"
            }
            self.workTimeLabel.text = "--"
            self.overTimeLabel.text = "--"
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func detailButtonAction(_ sender: UIButton) {
        if let _delegate = delegate{
            _delegate.detailsButtonActionAt(index: self.tag)
        }
    }
    
}
