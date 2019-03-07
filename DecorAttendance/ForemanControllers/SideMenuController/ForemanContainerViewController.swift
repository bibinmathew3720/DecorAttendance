//
//  ForemanContainerViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 05/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit
import QuartzCore

class ForemanContainerViewController: UIViewController {

    enum SlideOutState {
        
        case collapsed
        case leftPanelExpanded
    }
    
    var centerNavigationController: UINavigationController!
    var foremanCenterViewController: ForemanCenterViewController!
    var currentState: SlideOutState = .collapsed
    var foremanLeftViewController: ForemanLeftViewController?
    let centerPanelExpandedOffset: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foremanCenterViewController = UIStoryboard.foremanCenterViewController()
        foremanCenterViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: foremanCenterViewController)
        centerNavigationController.navigationBar.backgroundColor = .red
        view.addSubview(centerNavigationController.view)
        addChild(centerNavigationController)
        
        centerNavigationController.didMove(toParent: self)
        
        
        // Do any additional setup after loading the view.
    }
    
    
}
extension UIStoryboard {
    
    static func foremanStoryboard() -> UIStoryboard { return UIStoryboard(name: "Foreman", bundle: Bundle.main) }
    
    static func foremanLeftViewController() -> ForemanLeftViewController? {
        return foremanStoryboard().instantiateViewController(withIdentifier: "ForemanLeftViewControllerID") as? ForemanLeftViewController
    }
    
    //    static func rightViewController() -> SidePanelViewController? {
    //        return mainStoryboard().instantiateViewController(withIdentifier: "RightViewController") as? SidePanelViewController
    //    }
    
    static func foremanCenterViewController() -> ForemanCenterViewController? {
        return foremanStoryboard().instantiateViewController(withIdentifier: "ForemanCenterViewControllerID") as? ForemanCenterViewController
    }
}
// MARK: CenterViewController delegate

extension ForemanContainerViewController: ForemanCenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
        
    }
    
    func toggleRightPanel() {
    }
    
    func addLeftPanelViewController() {
        
        guard foremanLeftViewController == nil else { return }
        
        if let vc = UIStoryboard.foremanLeftViewController() {
            vc.foremanLeftControllerDelegate = foremanCenterViewController
            addChildSidePanelController(vc)
            foremanLeftViewController = vc
        }
        
        
    }
    
    func addChildSidePanelController(_ sidePanelController: ForemanLeftViewController) {
        
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    
    func addRightPanelViewController() {
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        
        if shouldExpand {
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(
                targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
            
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .collapsed
                self.foremanLeftViewController?.view.removeFromSuperview()
                self.foremanLeftViewController = nil
            }
        }
    }
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: {
                        self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    func animateRightPanel(shouldExpand: Bool) {
    }
    func collapseSidePanel() {
        
        switch currentState {
        case .leftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }

}
