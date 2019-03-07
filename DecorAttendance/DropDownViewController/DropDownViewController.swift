//
//  DropDownViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 18/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

public enum DropDownNeededFor{
    
    case Month
    case Date
    case Site
    case Attendance
    
}

protocol DropDownDataDelegate: class {
    
    func changedValue(is value: String!, dropDownType: DropDownNeededFor, index: Int)
    
}

class DropDownViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableViewDropDown: UITableView!
    
    var tableCgPoint: CGPoint!
    var monthArr: NSMutableArray!
    var dateArr: NSMutableArray!
    var siteArr: NSMutableArray!
    var attendanceArr: NSMutableArray!
    var dropDownNeededFor: DropDownNeededFor!
    var selectedValue: String!
    var widthTable: CGFloat!
    
    weak var delegate: DropDownDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewStyle()
        
        if self.widthTable == nil{
            
            widthTable = 88
        }
        
        self.tableViewDropDown.delegate = self
        self.tableViewDropDown.dataSource = self
        self.view.backgroundColor = .clear
        self.tableViewDropDown.frame.origin.x = tableCgPoint.x
        self.tableViewDropDown.frame.origin.y = tableCgPoint.y
        self.tableViewDropDown.frame.size.width = widthTable
        
    }
    
    func getDropDownArrToLoad() -> NSMutableArray {
        
        switch self.dropDownNeededFor! {
        case .Date:
            return dateArr
        case .Month:
            return monthArr
        case .Site:
            return siteArr
        case .Attendance:
            return attendanceArr
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getDropDownArrToLoad().count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDropDown", for: indexPath)
        cell.textLabel?.text = String(getDropDownArrToLoad().object(at: indexPath.row) as! String)
        cell.textLabel?.textAlignment = .left
        
        ObeidiTextStyle.setLabelFontStyleAndSize(label: cell.textLabel!, fontSize: ObeidiFont.Size.smallA(), fontColor: ObeidiFont.Color.obeidiExactBlack(), fontName: ObeidiFont.Family.normalFont())
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedValue = String(getDropDownArrToLoad().object(at: indexPath.row) as! String)
        
        delegate?.changedValue(is: self.selectedValue, dropDownType: self.dropDownNeededFor, index: indexPath.row)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setViewStyle()  {
        
        let layer = self.tableViewDropDown!
        layer.backgroundColor = UIColor.white
        layer.layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.21).cgColor
        layer.layer.shadowOpacity = 1
        layer.layer.shadowRadius = 4
        
        
    }
    
}
