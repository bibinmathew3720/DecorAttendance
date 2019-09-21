//
//  ReportFilterVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/21/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ReportFilterVC: UIViewController {

    @IBOutlet weak var fromDateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toDateButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        customisation()
        // Do any additional setup after loading the view.
    }
    
    func customisation(){
       fromDateButton.setRoundedRedBorder()
       toDateButton.setRoundedRedBorder()
       cancelButton.setRoundedRedBackgroundView()
       okButton.setRoundedRedBackgroundView()
    }
    
    @IBAction func fromDateButtonAction(_ sender: UIButton) {
        showDatePicker(filterType: .startDate)
    }
    
    @IBAction func toDateButtonAction(_ sender: UIButton) {
        showDatePicker(filterType: .endDate)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonAction(_ sender: UIButton) {
    }
    
    func showDatePicker(filterType:FilterTypeName){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let calendarViewController = storyboard.instantiateViewController(withIdentifier: "POPUPSelectorViewControllerID") as! POPUPSelectorViewController
            calendarViewController.delegate = self
            calendarViewController.filterTypeName = filterType
            calendarViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            calendarViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(calendarViewController, animated: true, completion: nil)
            
        }
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

extension ReportFilterVC : filterUpdatedDelegate{
    func filterValueUpdated(to value: AnyObject!, updatedType: FilterTypeName!) {
        
    }
    
    func dateUpdated(to date: String, updatedType: FilterTypeName!) {
        
    }
    
    func calendarColsed() {
        
    }
    
    func doneButtonActionDelegateWithSelectedDate(date: String, type: FilterTypeName) {
        
    }
    
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName) {
        
    }
    
    
}
