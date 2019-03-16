//
//  POPUPSelectorViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 13/02/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit
import JTAppleCalendar

protocol filterUpdatedDelegate: class  {
    
    func filterValueUpdated(to value: AnyObject!, updatedType: FilterTypeName!)
    func dateUpdated(to date: String, updatedType: FilterTypeName!)
    func calendarColsed()
    func doneButtonActionDelegateWithSelectedDate(date:String,type:FilterTypeName)
}

public enum FilterTypeName {
    
    case startDate
    case endDate
    case site
    case attendanceType
    
}

class POPUPSelectorViewController: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewFilter: UITableView!
    @IBOutlet weak var bttnDoneCalendar: UIButton!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var viewCalendarContainer: UIView!
    @IBOutlet weak var calenderView: JTAppleCalendarView!
    
    let formatter = DateFormatter()
    var yearVal: Int = 2018
    var monthVal: Int!
    weak var delegate: filterUpdatedDelegate!
    
    
    var isStartDateNeeded: Bool!
    var isEndDateNeeded: Bool!
    var isSiteNeeded: Bool!
    
    var filterDataArr: NSMutableArray!
    var filterTypeName: FilterTypeName!
    var selectedDate:String = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let currentYear = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let currentMonth = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let currentDay = formatter.string(from: date)
        print(currentDay)
        monthVal = Int(currentMonth)
        yearVal = Int(currentYear)!
        
        calenderView.backgroundColor = ObeidiColors.ColorCode.obeidiRed()
        calenderView.calendarDelegate = self
        calenderView.calendarDataSource = self
        
        tableViewFilter.backgroundColor = ObeidiColors.ColorCode.obeidiRed()
        tableViewFilter.layer.cornerRadius = 10.0
        
        self.tableViewFilter.delegate = self
        self.tableViewFilter.dataSource = self
        
        self.addTapGesturesToView()
        self.setupCalendarView()
        self.handleByFilterType()
        
        self.view.backgroundColor = UIColor.clear
        viewCalendarContainer.layer.cornerRadius = 8.0
        self.bttnDoneCalendar.backgroundColor = ObeidiColors.ColorCode.obeidiButtonAsh()
        self.bttnDoneCalendar.layer.cornerRadius = 8.0
        self.bttnDoneCalendar.setTitleColor(ObeidiColors.ColorCode.obeidiLineRed(), for: .normal)
        
        
    }
    
    override func viewDidLayoutSubviews(){
        
        tableViewFilter.frame = CGRect(x: tableViewFilter.frame.origin.x, y: tableViewFilter.frame.origin.y, width: tableViewFilter.frame.size.width, height: tableViewFilter.contentSize.height)
        tableViewFilter.reloadData()
        
    }
    
    func handleByFilterType() {
        
        let checkingCase = (self.filterTypeName as FilterTypeName)
        switch checkingCase {
            
        case .startDate:
            
            DispatchQueue.main.async {
                self.animateCalendarViewAppearance()
                
            }
            self.tableViewFilter.isHidden = true
            self.viewCalendarContainer.isHidden = false
            self.tableViewFilter.isUserInteractionEnabled = false
            self.viewCalendarContainer.isUserInteractionEnabled = true
            
            break
            
        case .endDate:
            DispatchQueue.main.async {
                self.animateCalendarViewAppearance()
                
            }
            self.tableViewFilter.isHidden = true
            self.viewCalendarContainer.isHidden = false
            self.tableViewFilter.isUserInteractionEnabled = false
            self.viewCalendarContainer.isUserInteractionEnabled = true
            
            break
        case .site:
            print("")
            DispatchQueue.main.async {
                self.animateCountryViewAppearance()
                
            }
            self.tableViewFilter.isHidden = false
            self.viewCalendarContainer.isHidden = true
            self.tableViewFilter.isUserInteractionEnabled = true
            self.viewCalendarContainer.isUserInteractionEnabled = false
            self.tableViewFilter.reloadData()
            break
        
        case .attendanceType:
            print("")
            DispatchQueue.main.async {
                self.animateCountryViewAppearance()
                
            }
            self.tableViewFilter.isHidden = false
            self.viewCalendarContainer.isHidden = true
            self.tableViewFilter.isUserInteractionEnabled = true
            self.viewCalendarContainer.isUserInteractionEnabled = false
            self.tableViewFilter.reloadData()
            break
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCalendarView()  {
        
        //spacing
        calenderView.minimumLineSpacing = 0
        calenderView.minimumInteritemSpacing = 0
        // label setup
        calenderView.visibleDates { visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
            
        }
        lblMonth.textColor = .white
        lblYear.textColor = .white
        self.viewCalendarContainer.backgroundColor = ObeidiColors.ColorCode.obeidiLineRed()
        
    }
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        lblYear.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        lblMonth.text = formatter.string(from: date)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if (touch.view?.isDescendant(of: viewCalendarContainer))! || (touch.view?.isDescendant(of: tableViewFilter))!{
            
            return false
        }
        return true
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "cellCalendarDate", for: indexPath) as! CalenderViewCell
        
        cell.dateLabel.text = cellState.text
        cell.dateLabel.textColor = UIColor.white
        cell.viewSelected.layer.cornerRadius = cell.viewSelected.frame.size.height / 2
        
        if cellState.isSelected {
            cell.viewSelected.isHidden = false
            
        }else{
            cell.viewSelected.isHidden = true
            if cellState.dateBelongsTo == .thisMonth{
                cell.dateLabel.textColor = .white
                
            }else{
                cell.dateLabel.textColor = .gray
                
            }
        }
        
        return cell
        
    }
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        
        
    }
    
    
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        let yearStrVal = String(yearVal)
        let monthStrVal = String(monthVal)
        self.formatter.dateFormat = "yyyy MM dd"
        self.formatter.timeZone = Calendar.current.timeZone
        self.formatter.locale = Calendar.current.locale
        let startDate = formatter.date(from: yearStrVal + " " + monthStrVal + " 01")
        let endDate = formatter.date(from: "2050 01 01")
        
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        
        return  parameters
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        if cellState.isSelected{
            self.formatter.dateFormat = "yyyy-MM-dd"//"yyyy MM dd"
            self.formatter.timeZone = Calendar.current.timeZone
            self.formatter.locale = Calendar.current.locale
            let strDate = formatter.string(from: date)
            self.selectedDate = strDate;
            print(strDate)
            if self.filterTypeName == FilterTypeName.startDate {
                //delegate.dateUpdated(to: strDate, updatedType: self.filterTypeName)
                
            }else if self.filterTypeName == FilterTypeName.endDate {
               // delegate.dateUpdated(to: strDate, updatedType: self.filterTypeName)
                
            }
            
            
        }
        
        guard let validCell = cell as? CalenderViewCell else {return}
        validCell.viewSelected.isHidden = false
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = cell as? CalenderViewCell else {return}
        print("selected date is \(date)")
        validCell.viewSelected.isHidden = true
        self
        
        
    }
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        //        let date = visibleDates.monthDates.first!.date
        //
        //        formatter.dateFormat = "yyyy"
        //        lblYear.text = formatter.string(from: date)
        //
        //        formatter.dateFormat = "MMMM"
        //        lblMonth.text = formatter.string(from: date)
        self.setupViewsOfCalendar(from: visibleDates)
        
    }
    //tableview delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.filterDataArr != nil{
            if self.filterDataArr.count == 0{
                self.showAlert(alertMessage: "There is nothing to show")
                
            }
            return self.filterDataArr.count
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch filterTypeName! {
        case .site:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellFilterTableViewCell") as! FilterTableViewCell
            let cellDataObj = self.filterDataArr.object(at: indexPath.row) as! ObeidiModelSites
            let name = cellDataObj.name as! String
            cell.setCellContents(cellData: name)
            
            return cell
        case .attendanceType:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellFilterTableViewCell") as! FilterTableViewCell
            let name = self.filterDataArr.object(at: indexPath.row) as! String
            
            cell.setCellContents(cellData: name)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellFilterTableViewCell") as! FilterTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch filterTypeName! {
        case .site:
            
            let cellDataObj = self.filterDataArr.object(at: indexPath.row) as! ObeidiModelSites
            let name = cellDataObj.name as! String
            let id = String(cellDataObj.id as! Int)
            let bonus_budget = ObeidiaTypeFormatter.stringFromCGFloat(floatVal: (cellDataObj.bonus_budget as! CGFloat))
            let remaining_bonus = ObeidiaTypeFormatter.stringFromCGFloat(floatVal: (cellDataObj.remaining_bonus as! CGFloat))
            let passDict = NSMutableDictionary()
            passDict.setValue(name, forKey: "name")
            passDict.setValue(id, forKey: "id")
            passDict.setValue(remaining_bonus, forKey: "remaining_bonus")
            passDict.setValue(bonus_budget, forKey: "bonus_budget")
            User.BonusDetails.bonus_budget = bonus_budget
            User.BonusDetails.remaining_bonus = remaining_bonus
            
            
            delegate.filterValueUpdated(to: passDict, updatedType: self.filterTypeName)
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.viewCalendarContainer.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                self.tableViewFilter.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                
            },completion:nil)
            delegate.calendarColsed()
            self.dismiss(animated: true, completion: nil)
        case .attendanceType:
            
            let name = self.filterDataArr.object(at: indexPath.row) as! String
            
            delegate.filterValueUpdated(to: name as AnyObject, updatedType: self.filterTypeName)
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.viewCalendarContainer.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                self.tableViewFilter.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                
            },completion:nil)
            delegate.calendarColsed()
            self.dismiss(animated: true, completion: nil)
            
        default:
            print("no actions needed. ")
        }
        
        
    }
    
    
    
    func addTapGesturesToView()  {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(POPUPSelectorViewController.respondsToTapGesture))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
        
    }
    
    @objc func respondsToTapGesture(){
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.viewCalendarContainer.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.tableViewFilter.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)

        },completion:nil)
        delegate.calendarColsed()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func animateCalendarViewAppearance() {
        
        
        viewCalendarContainer.alpha = 1
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.isCumulative = true
        animation.autoreverses = false
        animation.repeatCount = 1
        
        viewCalendarContainer.layer.add(animation, forKey: "calendarViewAnimationKey")
        
    }
    func animateCountryViewAppearance() {
        
        
        tableViewFilter.alpha = 1
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.isCumulative = true
        animation.autoreverses = false
        animation.repeatCount = 1
        
        tableViewFilter.layer.add(animation, forKey: "calendarViewAnimationKey")
        
    }
    
    @IBAction func bttnActnMinusYear(_ sender: Any) {
        
        self.yearVal = self.yearVal  - 1
        calenderView.reloadData()
        setupCalendarView()
        
    }
    @IBAction func bttnActnPlusYear(_ sender: Any) {
        
        self.yearVal = self.yearVal  + 1
        calenderView.reloadData()
        setupCalendarView()
        
    }
    
    func callLoadNationalityAPI()  {
        
        
        
    }
    
    
    
    @IBAction func bttnActnPlusMonth(_ sender: Any) {
        
        if monthVal != 1{
            self.monthVal = self.monthVal - 1
            calenderView.reloadData()
            setupCalendarView()
            
            
        }
        
        
    }
    
    
    @IBAction func bttnActnMinusMonth(_ sender: Any) {
        
        if self.monthVal != 12{
            self.monthVal = self.monthVal + 1
            calenderView.reloadData()
            setupCalendarView()
            
        }
        
    }
    
    @IBAction func bttnActnDoneCalender(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.viewCalendarContainer.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.tableViewFilter.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            
        },completion:nil)
        delegate.doneButtonActionDelegateWithSelectedDate(date: self.selectedDate
            , type: self.filterTypeName)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func showAlert(alertMessage: String) {
        let alertData = alertMessage
        let alert = UIAlertController(title: "Qomply Alert", message: alertData, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
            self.delegate.calendarColsed()
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}
