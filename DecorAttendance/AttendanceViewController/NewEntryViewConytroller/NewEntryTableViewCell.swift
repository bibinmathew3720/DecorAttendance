//
//  NewEntryTableViewCell.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 20/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit
import Kingfisher

class NewEntryTableViewCell: UITableViewCell {
   
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imageViewLabour: UIImageView!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setViewStyle()
        // Initialization code
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
        
    }
    
    func setCellContents(cellData: ObeidiModelFetchAttendance) {
        
        self.lblID.text = String(cellData.emp_id as! Int)
        self.lblName.text = (cellData.name as! String)
        let imageBase = UserDefaults.standard.value(forKey: "attendanceImageBase") as! String
        
        let imageUrl = URL(string: imageBase + (cellData.image as! String) )
        
        self.imageViewLabour.kf.setImage(with: imageUrl)
        
        
        
    }

}
