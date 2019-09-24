//
//  ExpirationPopupVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/24/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ExpirationPopupVC: UIViewController {

    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        customisation()

        // Do any additional setup after loading the view.
    }
    
    func customisation(){
        okButton.setRoundedRedBackgroundView()
    }
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
