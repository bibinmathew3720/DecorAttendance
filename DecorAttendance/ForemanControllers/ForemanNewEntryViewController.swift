//
//  ForemanNewEntryViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 06/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ForemanNewEntryViewController: UIViewController , DropDownDataDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableViewNewEntry: UITableView!
    @IBOutlet weak var viewDropDownButtons: UIView!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var switchTillDate: UISwitch!
    
    var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.switchTillDate.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        self.navigationItem.backBarButtonItem?.title = ""
        
        txtFldSearch.delegate = self
        tableViewNewEntry.delegate = self
        tableViewNewEntry.dataSource = self
        
        setUpViewStyles()
        addTapGesturesToLabels()
        addTapgesturesToView()
        
        
        // Do any additional setup after loading the view.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if (touch.view?.isDescendant(of: tableViewNewEntry))!{
            
            return false
        }
        return true
    }
    func setUpViewStyles() {
        
        let layer = self.viewSearchBar!
        layer.backgroundColor = UIColor.white
        layer.layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.2).cgColor
        layer.layer.shadowOpacity = 1
        layer.layer.shadowRadius = 8
        
        let layer1 = txtFldSearch!
        layer1.layer.cornerRadius = 3
        layer1.layer.borderWidth = 0.5
        layer1.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        
        self.lblMonth.layer.cornerRadius = 1
        self.lblMonth.layer.borderWidth = 0.5
        self.lblMonth.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblSite.layer.cornerRadius = 1
        self.lblSite.layer.borderWidth = 0.5
        self.lblSite.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblDay.layer.cornerRadius = 1
        self.lblDay.layer.borderWidth = 0.5
        self.lblDay.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1).cgColor
        
        self.lblDay.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblMonth.textColor = ObeidiFont.Color.obeidiLightBlack()
        self.lblSite.textColor = ObeidiFont.Color.obeidiLightBlack()
        
        addDropDownLabelAndImage(lblToModify: lblMonth, lblText: "Dec")
        addDropDownLabelAndImage(lblToModify: lblSite, lblText: "Quatar")
        addDropDownLabelAndImage(lblToModify: lblDay, lblText: "22")
        
        
    }
    
    func addDropDownLabelAndImage(lblToModify: UILabel, lblText: String) {
        
        let image = UIImage(named: "dropdown")
        let newSize = CGSize(width: 10, height: 10)
        
        //Resize image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image?.draw(in: CGRect(x:0, y:0, width: newSize.width, height: newSize.height))
        let imageResized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Create attachment text with image
        let attachment = NSTextAttachment()
        attachment.image = imageResized
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: lblText + "       " + "     ")
        myString.append(attachmentString)
        lblToModify.attributedText = myString
        
    }
    
    func addTapGesturesToLabels() {
        
        self.lblMonth.isUserInteractionEnabled = true
        let tapGestureMonth = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleMonthLabelTap))
        self.lblMonth.addGestureRecognizer(tapGestureMonth)
        
        self.lblSite.isUserInteractionEnabled = true
        let tapGestureSite = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleSiteLabelTap))
        self.lblSite.addGestureRecognizer(tapGestureSite)
        
        self.lblDay.isUserInteractionEnabled = true
        let tapGestureDay = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleDateLabelTap))
        self.lblDay.addGestureRecognizer(tapGestureDay)
        
    }
    @objc func handleMonthLabelTap(){
        
        presentDropDownController(tableCgPoint: getPointForMonthTable(), dropDownFor: .Month, arr: fetchMonthArr())
        
        
    }
    @objc func handleDateLabelTap(){
        
        presentDropDownController(tableCgPoint: getPointForDateTable(), dropDownFor: .Date, arr: fetchDateArr())
        
    }
    @objc func handleSiteLabelTap(){
        
        presentDropDownController(tableCgPoint: getPointForSiteTable(), dropDownFor: .Site, arr: fetchSiteArr())
        
    }
    func presentDropDownController(tableCgPoint: CGPoint, dropDownFor:
        DropDownNeededFor, arr: NSMutableArray) {
        
        self.view.backgroundColor = ObeidiFont.Color.obeidiExactBlack()
        self.view.alpha = 0.4
        
        self.navigationController?.navigationBar.alpha = 0.7
        self.tabBarController?.tabBar.alpha = 0.7
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dropDownController = storyboard.instantiateViewController(withIdentifier: "DropDownViewControllerID") as! DropDownViewController
        dropDownController.tableCgPoint = tableCgPoint//CGPoint(x: self.viewDropDownButtons.frame.minX, y: self.viewDropDownButtons.frame.maxY) //+ (self.navigationController?.navigationBar.frame.size.height)!)
        dropDownController.widthTable = self.lblDay.frame.size.width
        dropDownController.dropDownNeededFor = dropDownFor
        dropDownController.delegate = self
        switch dropDownFor {
            
        case DropDownNeededFor.Date:
            dropDownController.dateArr = arr
            dropDownController.dropDownNeededFor = dropDownFor
        case DropDownNeededFor.Month:
            dropDownController.monthArr = arr
            dropDownController.dropDownNeededFor = dropDownFor
        case DropDownNeededFor.Site:
            dropDownController.siteArr = arr
            dropDownController.dropDownNeededFor = dropDownFor
            
        case .Attendance:
            
            dropDownController.dropDownNeededFor = dropDownFor
        }
        
        dropDownController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        dropDownController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(dropDownController, animated: true, completion: nil)
        
        
    }
    func fetchDateArr() -> NSMutableArray {
        
        let arr = NSMutableArray()
        for i in 1...31{
            
            arr.add(String(i))
            
        }
        return arr
    }
    
    func fetchMonthArr() -> NSMutableArray {
        
        var arr = NSMutableArray()
        arr = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        return arr
    }
    func fetchSiteArr() -> NSMutableArray {
        
        var arr = NSMutableArray()
        arr = ["Quatar", "Saudi", "Dubai"]
        return arr
    }
    func getPointForMonthTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblMonth.frame.minX, y: self.viewDropDownButtons.frame.maxY + 90)
        
    }
    func getPointForDateTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblMonth.frame.size.width + self.lblMonth.frame.minX + 12, y: self.viewDropDownButtons.frame.maxY + 90)
        
    }
    func getPointForSiteTable() -> CGPoint{
        
        return CGPoint(x: 12 + self.viewDropDownButtons.frame.minX + self.lblMonth.frame.minX + self.lblDay.frame.size.width + self.lblMonth.frame.size.width + 24, y: self.viewDropDownButtons.frame.maxY + 90)
        
    }
    func changedValue(is value: String!, dropDownType: DropDownNeededFor, index: Int) {
        
        switch  dropDownType {
        case .Date:
            addDropDownLabelAndImage(lblToModify: self.lblDay, lblText: value)
        case .Month:
            addDropDownLabelAndImage(lblToModify: self.lblMonth, lblText: value)
        case .Site:
            addDropDownLabelAndImage(lblToModify: self.lblSite, lblText: value)
        case .Attendance:
            print("  ")
            
        }
        
        
        self.view.backgroundColor = UIColor.white
        self.view.alpha = 1
        
        self.navigationController?.navigationBar.alpha = 1
        self.tabBarController?.tabBar.alpha = 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNewEnrtyForeman", for: indexPath) as! ForemanNewEntryTableViewCell
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 87
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toMarkAttendanceSceneSegue:NewEnrty", sender: Any.self)
        
        
    }
    //MARK: textfield delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        
    }
    func addTapgesturesToView()  {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewEntryViewController.dismissKeyBoard))
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
    }
    @objc func dismissKeyBoard()  {
        
        if activeTextField != nil{
            
            activeTextField.resignFirstResponder()
            
        }
        
        
    }
    
}
