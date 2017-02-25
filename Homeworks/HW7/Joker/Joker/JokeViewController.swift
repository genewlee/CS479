//
//  JokeViewController.swift
//  Joker
//
//  Created by Gene Lee on 1/16/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import UserNotifications

class JokeViewController: UIViewController {
    
    var jokes = JokeArray()
    var notificationsOkay: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeJokes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    
    /// Creates at least three different jokes and stores them in the jokes array
    func initializeJokes() {
        // Joke(first: "first line", second: "second line", third: "third line", answer: "answer line")
        // if a argument is not passed in, it is "" by default
        
        // Joke 1
        let joke1 = Joke(first: "Why did the python programmer", second: "have crooked teeth?", answer: "No braces")
        self.jokes.add(joke1)
        
        // Joke 2
        let joke2 = Joke(first: "How many programmers", second: "does it take to", third: "change a lightbulb?", answer: "Zero. That's a hardware problem.")
        self.jokes.add(joke2)
        
        // Joke 3
        let joke3 = Joke(first: "Why do the java programmers", second: "where glasses?", answer: "Because they can't C#")
        self.jokes.add(joke3)
        
        // Joke 4
        let joke4 = Joke(first: "Why are Assembly programmers", second: "always soaking wet?", answer: "They work below C-level.")
        self.jokes.add(joke4)
        
        // Joke 5
        let joke5 = Joke(first: "Why do programmers always mix up", second: "Halloween and Christmas?", answer: "Because Oct 31 == Dec 25!")
        self.jokes.add(joke5)
    }
    
    /// Randomly selects one of the jokes in the array and sets the line labels appropriately
    func chooseJoke() -> Joke? {
        
        if (jokes.count < 1) {
            messageLabel.text = "No jokes to schedule"
            return nil
        } else {
            
            // gets a random index into jokes array
            let randomJokeIndex = Int(arc4random_uniform(UInt32((self.jokes.count))))
            
            // return the Joke object
            return jokes.getJoke(randomJokeIndex)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // sets number of jokes to AddJokeViewController
        if (segue.identifier == "toTableView") {
            let tableViewController = segue.destination as! TableViewController
            tableViewController.jokes = self.jokes
        }
    }
    
    @IBAction func unwindfromTableView (segue: UIStoryboardSegue) {
        let tableVC = segue.source as! TableViewController
        self.jokes = tableVC.jokes
    }
    
    @IBAction func scheduleNotification(_ sender: UIButton) {
        if (notificationsOkay) {
            scheduleNotification()

        } else {
            messageLabel.text = "Notifications disabled"
        }
    }
    
    // Call from applicationDidEnterForeground or before notification
    func checkIfNotificationsStillOkay() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler: self.handleNotificationSettings)
    }
    
    func handleNotificationSettings (notificationSettings: UNNotificationSettings) {
        if (notificationSettings.alertSetting == .enabled) {
            self.notificationsOkay = true
            print("yes")
        } else {
            self.notificationsOkay = false
            print("no")
        }
    }
    
    // Called when schedule button is tapped
    func scheduleNotification () {
        if let joke = chooseJoke() as Joke? {
            let content = UNMutableNotificationContent()
            content.title = "Here's a joke. Tap for answer"
            content.body = "\(joke.firstLine) \(joke.secondLine) \(joke.thirdLine)"
            content.userInfo["message"] = "\(joke.answerLine)"
            
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
            
            messageLabel.text = "Joke scheduled"
        }
    }
    
    // When user taps the notification, this function is called
    func handleNotification (_ response: UNNotificationResponse) {
        let message = response.notification.request.content.userInfo["message"] as! String
        
        let alert = UIAlertController(title: "Answer", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            // execute some code when this option is selected
            self.messageLabel.text = ""
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
}

