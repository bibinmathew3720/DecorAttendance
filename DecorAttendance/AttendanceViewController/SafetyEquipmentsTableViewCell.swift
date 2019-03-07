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
    func setCellContents(cellData: ObeidiModelSafetyEquipments, isAllChecked: Bool) {
        
        self.lblPenaltyAmnt.text = String(cellData.penalty as! Int)
        self.lblEquipmentName.text = (cellData.name as! String)
        
        let imageBase = UserDefaults.standard.value(forKey: "safetyEquipmentsImageBase") as! String
        let imageUrl = URL(string: imageBase + (cellData.image as! String) )
        self.imageViewEquipment.kf.setImage(with: imageUrl)
        
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
