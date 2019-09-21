//
//  MedicalLeaveVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/17/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class MedicalLeaveVC: UIViewController {
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customisation()

        // Do any additional setup after loading the view.
    }
    
    func customisation(){
        startDateView.setBorderProperties()
        endDateView.setBorderProperties()
    }
    
    
    
    
    //MARK: Button Actions
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        showDatePicker(filterType: .startDate)
    }
    
    @IBAction func endButtonAction(_ sender: UIButton) {
        showDatePicker(filterType: .endDate)
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

extension MedicalLeaveVC : filterUpdatedDelegate{
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
