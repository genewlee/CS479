//
//  SecondViewController.swift
//  NavDemo
//
//  Created by Gene Lee on 2/2/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var myInt2: MyInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("2nd: myInt2 = \(myInt2.x)")
        myInt2.x = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
