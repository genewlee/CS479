//
//  ViewController.swift
//  SettingsTest
//
//  Created by Gene Lee on 2/16/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTextLabel: UILabel!
    
    func updateText () {
        //if (myTextLabel != nil) {
            if let myText = UserDefaults.standard.string(forKey: "name_preference") {
                myTextLabel.text = "Text Field = \(myText)"
            } else {
                myTextLabel.text = "Text Field = (empty)"
            }
            
        //}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

