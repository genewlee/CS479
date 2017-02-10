//
//  ViewController.swift
//  NavDemo
//
//  Created by Gene Lee on 2/2/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class MyInt {
    var x: Int = 1
}

class ViewController: UIViewController {

    var myInt1 = MyInt()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("1st: myInt1 = \(myInt1.x)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromOneToTwo") {
            let vc = segue.destination as! SecondViewController
            vc.myInt2 = myInt1
        }
    }

}

