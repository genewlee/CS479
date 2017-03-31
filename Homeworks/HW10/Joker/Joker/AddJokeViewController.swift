//
//  AddJokeViewController.swift
//  Joker
//
//  Created by Gene Lee on 2/1/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class AddJokeViewController: UIViewController, UITextFieldDelegate {

    var newJokeReady: Bool = false
    var numJokes: Int = 1
    var lineOne: String!
    var lineTwo: String!
    var lineThree: String!
    var lineAnswer: String!
    
    @IBOutlet weak var AddJokeTitleLabel: UILabel!
    @IBOutlet weak var Line1TextField: UITextField!
    @IBOutlet weak var Line2TextField: UITextField!
    @IBOutlet weak var Line3TextField: UITextField!
    @IBOutlet weak var AnswerTextField: UITextField!
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        if ((Line1TextField.text?.isEmpty)! || (AnswerTextField.text?.isEmpty)!) {
            // Pop up alert to enter a first line and answer
            let alertController = UIAlertController(title: "Oops", message: "Please enter at least Line 1 and Answer", preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(OkAction)
            present(alertController, animated: true, completion: nil)
        } else {
            self.lineOne = Line1TextField.text!
            self.lineTwo = Line2TextField.text!
            self.lineThree = Line3TextField.text!
            self.lineAnswer = AnswerTextField.text!
            newJokeReady = true
            performSegue(withIdentifier: "unwindFromAddJoke", sender: nil)
        }
    }
    
    // hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setTextFieldDelegates()
        AddJokeTitleLabel.text = "Enter New Joke #\(numJokes + 1)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTextFieldDelegates() {
        Line1TextField.delegate = self
        Line2TextField.delegate = self
        Line3TextField.delegate = self
        AnswerTextField.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
