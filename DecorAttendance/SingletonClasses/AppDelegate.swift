//
//  AppDelegate.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 15/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //hide back button title
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .highlighted)
//        let backImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
//        UINavigationBar.appearance().backIndicatorImage = backImage
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
//        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -80.0), for: .default)
        
        setNavBarStyle()
        //setTabBarStyles()
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        //UINavigationBar.appearance().barTintColor = UIColor.red
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        setNavigationBarProperties()
        initWindow()
        return true
    }
    
    func initWindow(){
        if UserDefaults.standard.bool(forKey: Constant.VariableNames.isLoggedIn){
             //if isSiteEngineer{
            let containerViewController = ContainerViewController()
            containerViewController.navigationController?.navigationBar.backgroundColor = ObeidiColors.ColorCode.obeidiRed()
            self.window!.rootViewController = containerViewController
        }
        else{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewControllerID")
            self.window?.rootViewController = loginVC
        }
    }
    
    func setNavigationBarProperties(){
        //UINavigationBar.appearance().barTintColor = Constant.Colors.CommonMeroonColor
        UINavigationBar.appearance().tintColor = Constant.Colors.whiteColor
        let attrs = [
            NSAttributedString.Key.foregroundColor: Constant.Colors.whiteColor,
            NSAttributedString.Key.font: UIFont(name: Constant.Font.AvenirBook, size: 22)!
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        if #available(iOS 10.0, *) {
            self.saveContext()
        } else {
            // Fallback on earlier versions
        }
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "DecorAttendance")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    @available(iOS 10.0, *)
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func setNavBarStyle() {
        
        //let gradient = CAGradientLayer()
        let sizeLength = UIScreen.main.bounds.size.height * 2
        //let sizeHeight = 
        let defaultNavigationBarPlusStatusBarFrame = CGRect(x: 0, y: -20, width: sizeLength, height: 64)
        
        //gradient.frame = defaultNavigationBarFrame
        
       // gradient.colors = [ObeidiColorMeter.hexStringToUIColor(hex: "#FF0017"),ObeidiColorMeter.hexStringToUIColor(hex: "#C90219"),ObeidiColorMeter.hexStringToUIColor(hex: "#AE031B"),ObeidiColorMeter.hexStringToUIColor(hex: "#9F041B")]
        
        
        
        
        
        
        
        //let layer = UIView(frame: CGRect(x: 0, y: 0, width: 360, height: 60))
        
        let gradient = CAGradientLayer()
        gradient.frame = defaultNavigationBarPlusStatusBarFrame//CGRect(x: 0, y: 0, width: 360, height: 60)
        gradient.colors = [
            UIColor(red:1, green:0, blue:0.09, alpha:1).cgColor,
            UIColor(red:0.79, green:0.01, blue:0.1, alpha:1).cgColor,
            UIColor(red:0.68, green:0.01, blue:0.11, alpha:1).cgColor,
            UIColor(red:0.62, green:0.02, blue:0.11, alpha:1).cgColor
        ]
        gradient.locations = [0, 0.6131886, 1, 1]
        gradient.startPoint = CGPoint(x: -0.11, y: -0.19)
        gradient.endPoint = CGPoint(x: 1.21, y: 1.45)
        UINavigationBar.appearance().setBackgroundImage(self.image(fromLayer: gradient), for: .default)
        
        //UIApplication.shared.statusBarView?.backgroundColor = .white// ObeidiColorMeter.hexStringToUIColor(hex: "#C90219")
        //layer.layer.addSublayer(gradient)
        
        //self.view.addSubview(layer)
        
    }
    
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return outputImage!
    }
    func setTabBarStyles() {
        if let tabBarController = self.window?.rootViewController as? UITabBarController {
            
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
        }
    }

}

