//
//  FilterTableViewCell.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 13/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFilterData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = ObeidiColors.ColorCode.obeidiLineRed()
        self.lblFilterData.textColor = .white
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellContents(cellData: String) {
        
        self.lblFilterData.text = cellData
        
    }

}
