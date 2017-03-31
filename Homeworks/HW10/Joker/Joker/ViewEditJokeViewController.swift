//
//  ViewEditJoViewController.swift
//  Joker
//
//  Created by Gene Lee on 3/30/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ViewEditJokeViewController: UIViewController, UITextFieldDelegate {

    var firstLine: String!
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
            JokeDb.db.editJoke(line: firstLine, first: Line1TextField.text!, second: Line2TextField.text!, third: Line3TextField.text!, answer: AnswerTextField.text!)
            performSegue(withIdentifier: "unwindFromViewEditJoke", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setTextFieldDelegates()
        self.initTextFields()
    }
    
    func initTextFields () {
        let joke = JokeDb.db.fetchJoke(first: firstLine)
        Line1TextField.text = joke.lineOne
        Line2TextField.text = joke.lineTwo
        Line3TextField.text = joke.lineThree
        AnswerTextField.text = joke.lineAnswer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false;
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
