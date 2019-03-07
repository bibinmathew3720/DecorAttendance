//
//  ForemanCompleteEntryViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 06/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ForemanCompleteEntryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var tableViewCompleteEntry: UITableView!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    
    var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFldSearch.delegate = self
        
        self.navigationItem.backBarButtonItem?.title = ""
        tableViewCompleteEntry.delegate = self
        tableViewCompleteEntry.dataSource = self
        setViewStyles()
        addTapgesturesToView()
        
        // Do any additional setup after loading the view.
    }
    func setViewStyles() {
        
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
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCompleteEntryForeman", for: indexPath) as! ForemanCompleteEntryTableViewCell
        cell.parentViewController = self
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 87
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        
    }
    func addTapgesturesToView()  {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CompleteEntriesViewController.dismissKeyBoard))
        
        self.view.addGestureRecognizer(tapGesture)
        
    }
    @objc func dismissKeyBoard()  {
        
        if activeTextField != nil{
            
            activeTextField.resignFirstResponder()
            
        }
        
        
    }
    
}
