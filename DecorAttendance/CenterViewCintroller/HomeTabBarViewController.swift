//
//  HomeTabBarViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 16/12/18.
//  Copyright © 2018 Sreejith n  krishna. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController, DashBoardDelegate, AttendanceDelegate {
    
    var delegateCenterView: CenterViewControllerDelegate?
    
    override var delegate: UITabBarControllerDelegate? {
        didSet { delegateCenterView = delegate as? CenterViewControllerDelegate }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setTabBarStyle()
        setTabBarStyles()
        self.selectedIndex = 1
        
//        let NVC = self.viewControllers![1] as! UINavigationController
//        let VC = NVC.viewControllers[0] as! DashBoardViewController
//        VC.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    
    func dashBoardDidTapedMenu(tabBarIndex: Int) {
        
        print("menu taped. ")
        delegateCenterView?.toggleLeftPanel?()
        
    }
    
    func attendanceDidTapedMenu(tabBarIndex: Int) {
        print("menu taped. ")
        delegateCenterView?.toggleLeftPanel?()
        
    }
    
//    func employeeDidTapedMenu(tabBarIndex: Int) {
//        print("menu taped. ")
//        delegateCenterView?.toggleLeftPanel?()
//        
//    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item == (self.tabBar.items)![0]{
            //Do something if index is 0
            print("employee")
//            let NVC = self.viewControllers![0] as! UINavigationController
//            let VC = NVC.viewControllers[0] as! EmployeesViewController
//            VC.delegate = self
        }
        
        else if item == (self.tabBar.items)![1]{
            //Do something if index is 1
            print("dash")
//            let NVC = self.viewControllers![1] as! UINavigationController
//            let VC = NVC.viewControllers[0] as! DashBoardViewController
//            VC.delegate = self
        }
        else if item == (self.tabBar.items)![2]{
            //Do something if index is 2
            print("attendance")
//            let NVC = self.viewControllers![2] as! UINavigationController
//            let VC = NVC.viewControllers[0] as! AttendanceViewController
//            VC.delegate = self
        }
        
    }
    
    func setTabBarStyles() {
        let tabBarController = self
        
        let tabGradientView = UIView(frame: tabBarController.tabBar.bounds)
        tabGradientView.backgroundColor = UIColor.white
        tabGradientView.translatesAutoresizingMaskIntoConstraints = false;
        
        
        tabBarController.tabBar.addSubview(tabGradientView)
        tabBarController.tabBar.sendSubviewToBack(tabGradientView)
        tabGradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tabGradientView.layer.shadowOffset = CGSize(width: 0, height: -1)
        tabGradientView.layer.shadowRadius = 9.0
        tabGradientView.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.13).cgColor
        tabGradientView.layer.shadowOpacity = 1
        tabBarController.tabBar.clipsToBounds = false
        tabBarController.tabBar.backgroundImage = UIImage()
        tabBarController.tabBar.shadowImage = UIImage()
        
        
        for item in self.tabBar.items!{
            item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
            item.image = item.image?.withRenderingMode(.alwaysOriginal)
        }
        
    }
}
