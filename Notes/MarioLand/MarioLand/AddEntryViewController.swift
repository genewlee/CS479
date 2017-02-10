//
//  AddEntryViewController.swift
//  MarioLand
//
//  Created by Gene Lee on 2/9/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController, UITextFieldDelegate {
    
    var newCharacterReady: Bool = false

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        if (nameTextField.text?.isEmpty)! {
            print("name empty")
        } else {
            self.newCharacterReady = true
            performSegue(withIdentifier: "unwindFromAddEntry", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
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
