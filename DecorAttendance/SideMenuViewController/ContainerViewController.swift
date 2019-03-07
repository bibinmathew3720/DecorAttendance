//
//  ContainerViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 16/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit
import QuartzCore

class ContainerViewController: UIViewController {

    enum SlideOutState {
        
        case collapsed
        case leftPanelExpanded
    }
    
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    var currentState: SlideOutState = .collapsed
    var leftViewController: LeftViewController?
    let centerPanelExpandedOffset: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        centerNavigationController.navigationBar.backgroundColor = .red
        view.addSubview(centerNavigationController.view)
        addChild(centerNavigationController)
        
        centerNavigationController.didMove(toParent: self)
        

        // Do any additional setup after loading the view.
    }
    

}
extension UIStoryboard {
    
    static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    static func leftViewController() -> LeftViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftViewControllerID") as? LeftViewController
    }
    
//    static func rightViewController() -> SidePanelViewController? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "RightViewController") as? SidePanelViewController
//    }
    
    static func centerViewController() -> CenterViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "CenterViewControllerID") as? CenterViewController
    }
}
// MARK: CenterViewController delegate

extension ContainerViewController: CenterViewControllerDelegate {
    
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
        
        guard leftViewController == nil else { return }
        
        if let vc = UIStoryboard.leftViewController() {
            vc.leftControllerDelegate = centerViewController
            addChildSidePanelController(vc)
            leftViewController = vc
        }
        
        
    }
    
    func addChildSidePanelController(_ sidePanelController: LeftViewController) {
        
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
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController = nil
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
