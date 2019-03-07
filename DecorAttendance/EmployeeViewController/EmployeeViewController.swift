//
//  EmployeeViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 19/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate {
    

    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var tableViewEmployee: UITableView!
    
    var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapgesturesToView()
        
        txtFldSearch.delegate = self
        self.tableViewEmployee.delegate = self
        self.tableViewEmployee.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        
        setViewStyle()

        // Do any additional setup after loading the view.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if (touch.view?.isDescendant(of: tableViewEmployee))!{
            
            return false
        }
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEmployee", for: indexPath) as! EmployeeTableViewCell
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 87
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toEmployeeDetailsSceneSegue:Employee", sender: Any.self)
        
        
    }
    //MARK: textfield delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        
    }
    
    func setViewStyle() {
        
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
    
    func addTapgesturesToView()  {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EmployeeViewController.dismissKeyBoard))
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
    }
    @objc func dismissKeyBoard()  {
        
        if activeTextField != nil{
            
            activeTextField.resignFirstResponder()
            
        }
        
        
    }

}
