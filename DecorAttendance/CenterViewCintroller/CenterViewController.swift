//
//  CenterViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 16/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController, LeftViewControllerDelegate {

    @IBOutlet weak var containerViewTabBar: UIView!
    
    var delegate: CenterViewControllerDelegate?
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
    func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    func getLeftViewController() -> LeftViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftViewControllerID") as? LeftViewController
    }
    
    func didSelectIndex(_ itemIndex: Int) {
    
        print("am at \(itemIndex)")
        delegate?.collapseSidePanel!()
        
        switch itemIndex {
        
        case 0:
            self.performSegue(withIdentifier: "toProfileSceneSegue:Center", sender: Any.self)
        case 1:
            self.performSegue(withIdentifier: "toAboutSceneSegue", sender: Any.self)
        case 2:
           self.performSegue(withIdentifier: "toChangePwdSceneSegue", sender: Any.self)
        case 3:
            UserDefaults.standard.setValue("", forKey: "accessToken")
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
//            let delegate = UIApplication.shared.delegate as! AppDelegate
//            delegate.initWindow()
        default:
            break
            
        }
        
    }
}
// MARK: - SidePanelViewControllerDelegate
//extension CenterViewController: leftViewControllerDelegate {
//
//    func didSelectIndex(_ itemIndex: Int) {
//
//        print("here.")
//
//    }
//}
