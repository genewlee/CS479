//
//  ViewController.swift
//  JokeSettings
//
//  Created by Gene Lee on 2/17/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sortByLabel: UILabel!
    @IBOutlet weak var shuffleOnLabel: UILabel!
    
    @IBOutlet weak var nameLabelGlobal: UILabel!
    @IBOutlet weak var restrictContentLabelGlobal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocalSettings()
        checkGlobalSettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkLocalSettings () {
        if (UserDefaults.standard.object(forKey: "sort_by") != nil) {
            let sortBy = UserDefaults.standard.integer(forKey: "sort_by")
            if (sortBy == 0) {
                sortByLabel.text = "Sort By: Rating"
            } else if (sortBy == 1) {
                sortByLabel.text = "Sort By: Views"
            }
        } else {
            sortByLabel.text = "Sort By: Rating"
            UserDefaults.standard.set(0, forKey: "sort_by")
        }
        if (UserDefaults.standard.object(forKey: "shuffle_on") != nil) {
            let shuffleOn = UserDefaults.standard.bool(forKey: "shuffle_on")
            if (shuffleOn) {
                shuffleOnLabel.text = "Shuffle: On"
            } else {
                shuffleOnLabel.text = "Shuffle: Off"
            }
        } else {
            shuffleOnLabel.text = "Shuffle: On"
            UserDefaults.standard.set(true, forKey: "shuffle_on")
        }
    }

    func checkGlobalSettings () {
        if (UserDefaults.standard.object(forKey: "name_preference") != nil) {
            let name = UserDefaults.standard.string(forKey: "name_preference")!
            nameLabelGlobal.text = "Name: \(name)"
        } else {
            nameLabelGlobal.text = "Name:"
        }
        
        if (UserDefaults.standard.object(forKey: "restrict_preference") != nil) {
            let rc = UserDefaults.standard.bool(forKey: "restrict_preference")
            if (rc) {
                restrictContentLabelGlobal.text = "Restrict Content: Yes"
            } else {
                restrictContentLabelGlobal.text = "Restrict Content: No"
            }
        } else {
            restrictContentLabelGlobal.text = "Restrict Content: Yes"
            UserDefaults.standard.set(true, forKey: "restrict_preference")
        }
    }

}

