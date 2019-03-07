//
//  LeftViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 16/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    @IBOutlet weak var tableViewMenuItems: UITableView!
    
   open weak var leftControllerDelegate: LeftViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableViewMenuItems.delegate = self
        //self.tableViewMenuItems.dataSource = self
        tableViewMenuItems.reloadData()
        
    }
}

// MARK: Table View Data Source
extension LeftViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenuItems", for: indexPath) as! MenuItemsTableViewCell
        cell.setCellContents(cellIndex: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
}

// Mark: Table View Delegate

extension LeftViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        leftControllerDelegate?.didSelectIndex(indexPath.row)
        
        
    }
}
