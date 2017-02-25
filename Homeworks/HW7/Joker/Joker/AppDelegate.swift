//
//  AppDelegate.swift
//  Joker
//
//  Created by Gene Lee on 1/16/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // ONLY executes when app is first launched
        // When app launched again it knows that this has already been asked and retains that setting
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert])
        { (granted, error) in
            // Enable or disable features based on authorization.
            let nc = self.window?.rootViewController as! UINavigationController
            let vc = nc.viewControllers[0] as! JokeViewController
            vc.notificationsOkay = granted
        }
        
        // Can view in the simulator -> Debug -> Open System Log...
        // Can use in replacement to print statements
        NSLog("launch options = \(launchOptions)")
        
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
        let nc = self.window?.rootViewController as! UINavigationController
        let vc = nc.viewControllers[0] as! JokeViewController
        vc.checkIfNotificationsStillOkay()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // will be called even the app is not running -> from iOS 10
    // it will do the normal app startup and call this from the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        print("user responded to notification while in background")
        // Do stuff with response here (non-blocking)
        let nc = self.window?.rootViewController as! UINavigationController
        let vc = nc.viewControllers[0] as! JokeViewController
        vc.handleNotification(response)
        completionHandler()
    }
    
    // while app in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        print("received notification while in foreground; display?")
        completionHandler([.alert]) // no options ([]) means no notification
    }
}

