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
    @IBOutlet weak var statusLabel: UILabel!
    
    
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
        self.lblName.text = cellData.name
        self.lblID.text = "OAA\(cellData.empId)"
        if let imageUrl = URL(string: cellData.profileBaseUrl+cellData.profileImageUrl){
            self.imageViewLabour.setImageWith(imageUrl, placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
        }
        if (cellData.isStartTimeMarked){
            self.statusLabel.text = "Start time marked";
        }
        else{
            self.statusLabel.text = "";
        }
    }

}
