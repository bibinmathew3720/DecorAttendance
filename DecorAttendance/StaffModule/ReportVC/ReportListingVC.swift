//
//  ReportListingVC.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/21/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ReportListingVC: UIViewController {
    @IBOutlet weak var reportListingTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Report"
        // Do any additional setup after loading the view.
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

extension ReportListingVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportListingCell", for: indexPath) as! ReportListingTVC
//        if let attendanceRes = self.completedEntriesResponseModel{
//            cell.setCellContents(cellData: attendanceRes.attendanceResultArray[indexPath.row])
//        }
        cell.tag = indexPath.row
       // cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
