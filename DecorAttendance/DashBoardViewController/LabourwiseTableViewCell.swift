//
//  LabourwiseTableViewCell.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 21/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class LabourwiseTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewLabour: UIImageView!
    @IBOutlet weak var lblPenaltyAmnt: UILabel!
    @IBOutlet weak var lblIncentiveAmnt: UILabel!
    @IBOutlet weak var lblNetSalary: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblIncentive: UILabel!
    @IBOutlet weak var lblPenalty: UILabel!
    @IBOutlet weak var lblNetSalaryAmnt: UILabel!
    
    @IBOutlet weak var bttnDetails: UIButton!
    
    @IBOutlet weak var viewVerticalSeperator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setViewStyle()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setMultipleColorsToLabelFont(lbl: lblIncentive, labelStr: "Total incentive    AED 200", loctn: 19, lngth: 7, fontFamily: ObeidiFont.Family.normalFont(), fontSize: ObeidiFont.Size.smallB())
        setMultipleColorsToLabelFont(lbl: lblPenalty, labelStr: "Total penalty    AED 50", loctn: 17, lngth: 6, fontFamily: ObeidiFont.Family.normalFont(), fontSize: ObeidiFont.Size.smallB())
        setMultipleColorsToLabelFont(lbl: lblNetSalary, labelStr: "Net salary    AED 150", loctn: 14, lngth: 7, fontFamily: ObeidiFont.Family.boldFont(), fontSize: ObeidiFont.Size.mediumA())
        // Configure the view for the selected state
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

        
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblName, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.boldFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblID, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblIncentive, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblPenalty, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblNetSalary, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.boldFont())
    }
    
    func setMultipleColorsToLabelFont(lbl: UILabel, labelStr: String, loctn: Int, lngth: Int, fontFamily: String, fontSize: CGFloat){
        
        let myString:NSString = labelStr as NSString
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: fontFamily, size: fontSize)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: ObeidiFont.Color.obeidiLineRed(), range: NSRange(location:loctn,length:lngth))
        // set label Attribute
        lbl.attributedText = myMutableString
    }
    
    func setCostSummary(costDetail:CostSummary){
        
    }

}
