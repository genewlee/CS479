//
//  ViewController.swift
//  NotifyDemp
//
//  Created by Gene Lee on 2/21/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var notificationsOkay: Bool = false

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func scheduleNotification(_ sender: UIButton) {
        if (notificationsOkay) {
            scheduleNotification()
        } else {
            messageLabel.text = "Notifications disabled"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (notificationsOkay) {
            print ("notifications allowed")
        } else {
            print ("notifications NOT allowed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Call from applicationDidEnterForeground or before notification
    func checkIfNotificationsStillOkay() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler:
            self.handleNotificationSettings)
    }
    
    func handleNotificationSettings (notificationSettings: UNNotificationSettings) {
        if ((notificationSettings.alertSetting == .enabled) &&
            (notificationSettings.badgeSetting == .enabled) &&
            (notificationSettings.soundSetting == .enabled)) {
            self.notificationsOkay = true
            print("yes")
        } else {
            self.notificationsOkay = false
            print("no")
        }
    }

    func scheduleNotification () {
        let content = UNMutableNotificationContent()
        content.title = "Hey!"
        content.body = "What’s up?"
        content.userInfo["message"] = "Yo!"
        
        // Configure trigger for 5 seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // Create request
        let request = UNNotificationRequest(identifier: "NowPlusFive", content: content, trigger: trigger)
        
        // Schedule request
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    
    func handleNotification (_ response: UNNotificationResponse) {
        let message = response.notification.request.content.userInfo["message"] as! String
        self.messageLabel.text = message
    }
    
}

