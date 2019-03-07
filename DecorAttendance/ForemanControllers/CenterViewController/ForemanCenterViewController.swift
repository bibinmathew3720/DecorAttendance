//
//  ForemanCenterViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 05/01/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

class ForemanCenterViewController: UIViewController, ForemanLeftViewControllerDelegate {

    @IBOutlet weak var containerViewTabBar: UIView!
    
    var delegate: ForemanCenterViewControllerDelegate?
    var window: UIWindow!
    //var leftViewController: LeftViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //leftViewController = getLeftViewController()
        //leftViewController.leftControllerDelegate = self
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
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
    
    @IBAction func bttnActnMenu(_ sender: Any) {
        //containerViewTabBar.alpha = 0
        delegate?.toggleLeftPanel?()
        
        
    }
    func foremanStoryboard() -> UIStoryboard { return UIStoryboard(name: "Foreman", bundle: Bundle.main) }
    
    func getLeftViewController() -> ForemanLeftViewController? {
        return foremanStoryboard().instantiateViewController(withIdentifier: "ForemanLeftViewControllerID") as? ForemanLeftViewController
    }
    
    func didSelectIndex(_ itemIndex: Int) {
        
        print("am at \(itemIndex)")
        delegate?.collapseSidePanel!()
        
        switch itemIndex {
            
        case 0:
            self.performSegue(withIdentifier: "toProfileSceneSegue:Center", sender: Any.self)
        case 1:
            print(":1")
        default:
            break
            
        }
        
    }

}
