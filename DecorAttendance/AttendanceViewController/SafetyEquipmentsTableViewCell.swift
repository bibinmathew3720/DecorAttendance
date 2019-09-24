//
//  SafetyEquipmentsTableViewCell.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 15/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

protocol buttonCheckedDelegate: class {
    
    func buttonCheckedStatus(isChecked: Bool, buttonIndex: Int)
    
}

class SafetyEquipmentsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPenaltyAmnt: UILabel!
    @IBOutlet weak var lblEquipmentName: UILabel!
    @IBOutlet weak var imageViewEquipment: UIImageView!
    @IBOutlet weak var bttnCheck: UIButton!
    @IBOutlet weak var innerView: UIView!
    
    var isButtonChecked: Bool!
    weak var checkButtonDelegate: buttonCheckedDelegate?
    var SafetyEquipmentsViewControllerVCRef: SafetyEquipmentsViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isButtonChecked = false
        bttnCheck.layer.borderWidth = 1
        bttnCheck.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        innerView.dropShadow()
        innerView.layer.cornerRadius = 4.0
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellContents(equipment: SafetyEquipment, isAllChecked: Bool) {
        self.lblPenaltyAmnt.text = "Penalty : \(equipment.penalty)"
        self.lblEquipmentName.text = equipment.name
         guard let encodedUrlstring = (equipment.imageBaseUrl.trimLeadingAndTrailingSpaces()+equipment.imageName.trimLeadingAndTrailingSpaces()).addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else { return  }
        if let imageUrl = URL(string: encodedUrlstring){
            self.imageViewEquipment.setImageWith(imageUrl, placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
        }
        if isAllChecked{
            self.bttnCheck.setImage(UIImage(named: "tick"), for: .normal)
            self.isButtonChecked = true
            
        }else{
            self.bttnCheck.setImage(UIImage(named: ""), for: .normal)
            self.isButtonChecked = false
        }
    }

    @IBAction func bttnActnCheck(_ sender: Any){
        
        isButtonChecked = !isButtonChecked
        if isButtonChecked{
            self.bttnCheck.setImage(UIImage(named: "tick"), for: .normal)
            checkButtonDelegate?.buttonCheckedStatus(isChecked: true, buttonIndex: bttnCheck.tag)
        }else{
            self.bttnCheck.setImage(UIImage(named: ""), for: .normal)
            checkButtonDelegate?.buttonCheckedStatus(isChecked: false, buttonIndex: bttnCheck.tag)
        }
    }
    
    func updateCheckAllStatus(vc:SafetyEquipmentsViewController){
        self.SafetyEquipmentsViewControllerVCRef = vc
    }
    
}
