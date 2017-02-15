//
//  ViewController.swift
//  SettingsDemo
//
//  Created by Gene Lee on 2/14/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var volumeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (UserDefaults.standard.object(forKey: "volume") != nil) {
            let volume = UserDefaults.standard.integer(forKey: "volume")
            volumeLabel.text = "Volume: \(volume)"
        } else {
            volumeLabel.text = "Volume: 10"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

