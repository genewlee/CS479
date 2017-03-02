//
//  ViewController.swift
//  GestureDemo
//
//  Created by Gene Lee on 2/28/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func tapDetected (recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: self.view)
        let xi = Int(point.x)
        let yi = Int(point.y)
        print("tap detected at (\(xi),\(yi))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

