//
//  LabourwiseTableViewCell.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 21/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

protocol LabourwiseTableViewCellDelegate{
    func detailButtonActionDelegate(button:UIButton)
}

class LabourwiseTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewLabour: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblIncentiveAmnt: UILabel!
    @IBOutlet weak var lblTotalPenalty: UILabel!
    @IBOutlet weak var lblNetSalary: UILabel!
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var bttnDetails: UIButton!
    @IBOutlet weak var viewVerticalSeperator: UIView!
    var labourCellDelegate:LabourwiseTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        setViewStyle()
        // Initialization code
    }
    
    func setViewStyle() {
        let layer = self.innerView!
        layer.layer.cornerRadius = 3
        layer.backgroundColor = UIColor.white
        layer.layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.35).cgColor
        layer.layer.shadowOpacity = 1
        layer.layer.shadowRadius = 7
        
        let bttn = bttnDetails!
        bttn.layer.cornerRadius = 1
        bttn.backgroundColor = UIColor(red:0.91, green:0.18, blue:0.18, alpha:1)
        
        let layer2 = viewVerticalSeperator!
        layer2.layer.borderWidth = 0.5
        layer2.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
    }
    
    func setCostSummary(costDetail:CostSummary){
        if let imageUrl = URL(string: costDetail.imageBaseUrl+costDetail.profileImageUrl){
            self.imageViewLabour.setImageWith(imageUrl, placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
        }
        self.lblName.text = costDetail.name
        self.lblID.text = "\(costDetail.empId)"
        self.lblIncentiveAmnt.text = "AED " + String(format: "%0.2f", costDetail.totalIncentive)
        self.lblTotalPenalty.text = "AED " + String(format: "%0.2f", costDetail.totalPenalty)
        self.lblNetSalary.text = "AED " + String(format: "%0.2f", costDetail.netSalary)
    }

    @IBAction func detailButtonAction(_ sender: UIButton) {
        if let delegate = self.labourCellDelegate{
            delegate.detailButtonActionDelegate(button: sender)
        }
    }
}
