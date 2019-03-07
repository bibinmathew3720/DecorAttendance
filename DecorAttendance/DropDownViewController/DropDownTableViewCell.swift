//
//  DropDownTableViewCell.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 18/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
 
    @IBOutlet weak var lblDropDownItem: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
