//
//  MenuItemsTableViewCell.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 16/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class MenuItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCellName: UILabel!
    @IBOutlet weak var cellIconImage: UIImageView!

    var menuItemsArr = ["Profile", "About", "Change Password", "Logout" ]
    var itemImagesNameArr = ["profile", "about", "change_password", "logout"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCellContents(cellIndex: Int)  {
        
        self.lblCellName.text = self.menuItemsArr[cellIndex]
        self.cellIconImage.image = UIImage(named: self.itemImagesNameArr[cellIndex])
        
    }
    
}
