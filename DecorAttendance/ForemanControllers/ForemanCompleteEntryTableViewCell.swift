//
//  ForemanCompleteEntryTableViewCell.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 06/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ForemanCompleteEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imageViewLabour: UIImageView!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblTotalBonusHeader: UILabel!
    @IBOutlet weak var lblTotalBonusAmnt: UILabel!
    
    var parentViewController: UIViewController!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setViewStyle()
        setMultipleColorsToLabelFont(lbl: lblTotalBonusHeader, labelStr: "Total bonus AED 200")
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
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
        
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblName, fontSize: ObeidiFont.Size.smallB(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.boldFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblID, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblStartTime, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblEndTime, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: lblTotalBonusHeader, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiMediumBlack(), fontName: ObeidiFont.Family.normalFont())
        
        //ObeidiTextStyle.setLabelFontStyleAndSize(label: lblTotalBonusAmnt, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiLineRed(), fontName: ObeidiFont.Family.normalFont())
        
        
        
    }
    
    func setMultipleColorsToLabelFont(lbl: UILabel, labelStr: String){
        
        let myString:NSString = labelStr as NSString
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: ObeidiFont.Family.normalFont(), size: ObeidiFont.Size.smallA())!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: ObeidiFont.Color.obeidiLineRed(), range: NSRange(location:12,length:7))
        // set label Attribute
        lbl.attributedText = myMutableString
        
        
        
    }
    
    func gotoEmployeeDetails() {
        
        //self.parentViewController.view.alpha = 0.5
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsController = storyboard.instantiateViewController(withIdentifier: "CompleteEntryDetailsViewControllerID") as! CompleteEntryDetailsViewController
        
        
        detailsController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        detailsController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.parentViewController.present(detailsController, animated: true, completion: nil)
        
    }
    
    @IBAction func bttnActnDetails(_ sender: Any) {
        
        gotoEmployeeDetails()
        
    }

}
