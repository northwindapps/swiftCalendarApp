//
//  AppDelegate.swift
//  Newcalendar
//
//  Created by yujinyano on 2018/07/21.
//  Copyright © 2018年 yujinyano. All rights reserved.
//

import UIKit
import CoreData
import AppTrackingTransparency
import AdSupport

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var scrollposition = 0
    var firstlaunch = 1
    var stringcache: String = ""
    var eviewdate = ""
    var returnstr = -1
    var returnMM = 1
    var returnDD = 1
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "mainview")
        
        self.window?.rootViewController = initialViewController
        self.window?.frame = self.window!.bounds
        self.window?.makeKeyAndVisible()
        
        if #available(iOS 14, *) {
            if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                // Tracking permission has not been requested yet, show the permission alert
                showTrackingPermissionAlert()
            }
        }
        
        return true
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

    }
    
    func requestTrackingPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorized
                    print("Tracking authorized")
                case .denied:
                    // Tracking denied
                    print("Tracking denied")
                case .restricted:
                    // Tracking restricted
                    print("Tracking restricted")
                case .notDetermined:
                    // Tracking not determined
                    print("Tracking not determined")
                @unknown default:
                    print("Unknown tracking status")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func showTrackingPermissionAlert() {
           let alertController = UIAlertController(
               title: "Tracking Permission",
               message: "We use tracking to personalize your experience and improve our app. Tap \"Allow\" to consent.",
               preferredStyle: .alert
           )
           
           let allowAction = UIAlertAction(title: "Allow", style: .default) { _ in
               // Request tracking permission when user taps Allow
               self.requestTrackingPermission()
               
           }
        
           let denyAction = UIAlertAction(title: "Deny", style: .default) { _ in
                // Request tracking permission when user taps Allow
               self.requestTrackingPermission()
                
           }
           
           alertController.addAction(allowAction)
        
           alertController.addAction(denyAction)
           
           if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
               // Show the alert only if tracking permission has not been determined
               if let rootViewController = self.window?.rootViewController {
                   rootViewController.present(alertController, animated: true, completion: nil)
               }
           }
       }

}

