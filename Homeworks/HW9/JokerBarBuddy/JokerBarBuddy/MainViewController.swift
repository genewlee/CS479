//
//  ViewController.swift
//  JokerBarBuddy
//
//  Created by Gene Lee on 3/25/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var lineOneLabel: UILabel!
    @IBOutlet weak var lineTwoLabel: UILabel!
    @IBOutlet weak var lineThreeLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBAction func getJokeTapped(_ sender: UIButton) {
        let url = URL(string: "http://www.eecs.wsu.edu/~holder/courses/MAD/hw9/getjoke.php")
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: handleGetJokeResponse)
        dataTask.resume()
    }
    
    func handleGetJokeResponse (data: Data?, response: URLResponse?, error: Error?) {
        if (error != nil) {
            print("error: \(error!.localizedDescription)")
        }
        else {
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if statusCode != 200 {
                let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                print("HTTP \(statusCode) error: \(msg)")
            } else {
                // response okay, serialize data
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: []) {
                    let jsonDict = jsonObj as! [String: AnyObject]
                    let joke = jsonDict["joke"] as! [String: AnyObject]
                    let lineOne = joke["line1"] as! String
                    let lineTwo = joke["line2"] as! String
                    let lineThree = joke["line3"] as! String
                    let answer = joke["answer"] as! String
                    DispatchQueue.main.async {
                        self.lineOneLabel.text = lineOne
                        self.lineTwoLabel.text = lineTwo
                        self.lineThreeLabel.text = lineThree
                        self.answerLabel.text = answer
                    }
                } else {
                    print("error: invalid JSON data")
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.lineOneLabel.text = ""
        self.lineTwoLabel.text = ""
        self.lineThreeLabel.text = ""
        self.answerLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}






