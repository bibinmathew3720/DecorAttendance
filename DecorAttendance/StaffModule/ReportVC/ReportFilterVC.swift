//
//  ReportFilterVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/21/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

protocol ReporterFilterVCDelegate {
    func okButtonActionDelegate(startDate:Date?,endDate:Date?)
}

class ReportFilterVC: UIViewController {

    @IBOutlet weak var fromDateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toDateButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var startDate:Date?
    var endDate:Date?
    var delegate:ReporterFilterVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        customisation()
        populaDates()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
    }
    
    func customisation(){
       fromDateButton.setRoundedRedBorder()
       toDateButton.setRoundedRedBorder()
       cancelButton.setRoundedRedBackgroundView()
       okButton.setRoundedRedBackgroundView()
    }
    
    func populaDates(){
        if let _date = startDate{
            fromDateButton.setTitle(_date.stringFromDate(format:"yyyy/MM"), for: .normal)
        }
        else{
           startDate = Date()
           fromDateButton.setTitle(Date().stringFromDate(format:"yyyy/MM"), for: .normal)
        }
        if let _date = endDate{
            toDateButton.setTitle(_date.stringFromDate(format:"yyyy/MM"), for: .normal)
        }
        else{
            endDate = Date()
            toDateButton.setTitle(Date().stringFromDate(format:"yyyy/MM"), for: .normal)
        }
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
        if let _delegate = delegate{
            _delegate.okButtonActionDelegate(startDate: self.startDate, endDate: self.endDate)
        }
        self.dismiss(animated: true, completion: nil)
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
    
    func doneButtonActionDelegateWithSelectedDate(date: String, type: FilterTypeName,dateInDateFormat:Date) {
        if type == .startDate{
            startDate =  dateInDateFormat
        }
        if type == .endDate{
            endDate =  dateInDateFormat
        }
        populaDates()
    }
    
    func selectedSite(selSite: ObeidiModelSites, withType: FilterTypeName) {
    }
    
    
}
