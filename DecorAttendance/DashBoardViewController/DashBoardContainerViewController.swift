//
//  DashBoardContainerViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 19/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class DashBoardContainerViewController: UIViewController {

    
    @IBOutlet weak var viewTopBar: UIView!
    @IBOutlet weak var lineIndicatorLabour: UIView!
    @IBOutlet weak var lineIndicatorSite: UIView!
    @IBOutlet weak var containerViewLBRWSE: UIView!
    @IBOutlet weak var containerViewSiteWSE: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewStyles()
        //animateIndicator(indicator: self.lineIndicatorSite)

        // Do any additional setup after loading the view.
    }
    
    func setViewStyles()  {
        
        self.title = "DashBoard"
        
        //self.viewTopBar.applyCustomGradient(colors: ObeidiColors.Gradients.topBarRedGradients())
        
    }

    @IBAction func bttnActnLabourwise(_ sender: Any) {
        
        self.containerViewLBRWSE.alpha = 1.0
        self.containerViewLBRWSE.isUserInteractionEnabled = true
        
        self.containerViewSiteWSE.alpha = 0.0
        self.containerViewSiteWSE.isUserInteractionEnabled = false
        
        lineIndicatorSite.backgroundColor = ObeidiFont.Color.obeidiLineRed()
        lineIndicatorLabour.backgroundColor = ObeidiFont.Color.obeidiLineWhite()
        
        //animateIndicator(indicator: self.lineIndicatorSite)

    }
    
    @IBAction func bttnActnSitewise(_ sender: Any) {
        
        self.containerViewLBRWSE.alpha = 0.0
        self.containerViewLBRWSE.isUserInteractionEnabled = false
        
        self.containerViewSiteWSE.alpha = 1.0
        self.containerViewSiteWSE.isUserInteractionEnabled = true
        
        lineIndicatorLabour.backgroundColor = ObeidiFont.Color.obeidiLineRed()
        lineIndicatorSite.backgroundColor = ObeidiFont.Color.obeidiLineWhite()
        
        //animateIndicator(indicator: self.lineIndicatorSite)
        
    }
    
    func animateIndicator(indicator: UIView) {
        
        let viewWidth = indicator.frame.width
        let viewHeight = indicator.frame.height
        
        indicator.frame = CGRect(x: self.lineIndicatorLabour.frame.minX, y: self.lineIndicatorLabour.frame.minY, width: 0, height: viewHeight)
        
        UIView.animate(withDuration: 0.4) {
            indicator.frame = CGRect(x: indicator.frame.minX, y: indicator.frame.minY, width: viewWidth, height: viewHeight)
        }
        indicator.frame = CGRect(x: self.lineIndicatorLabour.frame.minX, y: self.lineIndicatorLabour.frame.minY, width: viewWidth, height: viewHeight)
    }
}
