//
//  EmployeeTableViewCell.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 19/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var widthUnColoredIndctr: NSLayoutConstraint!
    @IBOutlet weak var widthColoredIndctr: NSLayoutConstraint!
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var viewUnColoured: UIView!
    @IBOutlet weak var viewColoured: UIView!
    @IBOutlet weak var imageViewLabour: UIImageView!
    
    @IBOutlet weak var lblLabourRating: UILabel!
    @IBOutlet weak var lblSalaryPerDay: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setViewStyle()
        setIndicatorValue(value: 0.72)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setViewStyle() {
        
        let layer = self.innerView!
        layer.layer.cornerRadius = 3
        layer.backgroundColor = UIColor.white
        layer.layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.35).cgColor
        layer.layer.shadowOpacity = 1
        layer.layer.shadowRadius = 7
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblName, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.boldFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblID, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblSalaryPerDay, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblLabourRating, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        
    }
    func setIndicatorValue(value: CGFloat) {
        
        ObeidiPerformanceIndicatorStyle.setIndicatorsByValues(lineA: self.viewUnColoured, lineB: self.viewColoured, lineAColor: ObeidiFont.Color.obeidiLineWhite(), lineBColor: ObeidiColors.ColorCode.obeidiLineGreen(), lineAValue: 1, lineBValue: value, lineAMeter: widthUnColoredIndctr, lineBMeter: widthColoredIndctr)
        
    }
    
    func setCell(model:DecoreEmployeeModel){
        lblID.text = "ID" + String(model.emp_id)
        lblName.text = model.name
        imageViewLabour.loadImageUsingCache(withUrl: model.image, colorValue: nil)
        let rating = Double(model.rating)
        if let rat = rating{
            widthColoredIndctr.constant = CGFloat(4 * rat)
        }
        
        lblLabourRating.text = model.rating + "/" + String(model.total_rating)
        lblSalaryPerDay.text = "Labour salary rate " + String(model.wage_hourly) + "AED day"
    }
    
}
