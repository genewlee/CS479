//
//  ViewController.swift
//  AlertDemo
//
//  Created by Gene Lee on 2/21/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func AlertButton(_ sender: UIButton) {
        doAlert()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeLoginAlert()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doAlert() {
        let alert = UIAlertController(title: "Favorite Character",
                                      message: "Please choose your favorite Mario character.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Mario", style: .default, handler: { (action) in
            // execute some code when this option is selected
            print("Favorite character is Mario")
        }))
        
        alert.addAction(UIAlertAction(title: "Luigi", style: .destructive, handler: { (action) in
            // execute some code when this option is selected
            print("Favorite character is Luigi")
        }))
        
        alert.addAction(UIAlertAction(title: "Yoshi", style: .cancel, handler: { (action) in
            // execute some code when this option is selected
            print("Favorite character is Luigi")
        }))
        present(alert, animated: true, completion: nil)
    }
    
    var loginAlert: UIAlertController!
    
    func initializeLoginAlert() {
        loginAlert = UIAlertController(title: "Login", message: "Provide your username and password.", preferredStyle: .alert)
        loginAlert.addTextField(configurationHandler: usernameTextFieldHandler)
        loginAlert.addTextField(configurationHandler: passwordTextFieldHandler)
        loginAlert.addAction(UIAlertAction(title: "Login", style: .default,
        handler: { (action) in
            let username = self.loginAlert.textFields?[0].text
            let password = self.loginAlert.textFields?[1].text
            print("username = \(username), password = \(password)")}))
        
        // cancel login
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
            // execute some code when this option is selected
        }))
    }
    
    func usernameTextFieldHandler (_ textField: UITextField) {
        textField.placeholder = "Username"
    }
    
    func passwordTextFieldHandler (_ textField: UITextField) {
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
    }
    
    @IBAction func alertWithText(_ sender: UIButton) { self.present(loginAlert, animated: true, completion: nil)
    }
}

