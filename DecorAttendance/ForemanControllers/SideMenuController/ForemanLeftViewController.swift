//
//  ForemanLeftViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 05/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ForemanLeftViewController: UIViewController {

    @IBOutlet weak var tableViewMenuItems: UITableView!
    
    open weak var foremanLeftControllerDelegate: ForemanLeftViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewMenuItems.delegate = self
        self.tableViewMenuItems.dataSource = self
        tableViewMenuItems.reloadData()
        
    }
}

// MARK: Table View Data Source
extension ForemanLeftViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenuItemsForeman", for: indexPath) as! ForemanMenuItemsTableViewCell
        cell.setCellContents(cellIndex: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
}

// Mark: Table View Delegate

extension ForemanLeftViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        foremanLeftControllerDelegate?.didSelectIndex(indexPath.row)
        
        
    }

}
