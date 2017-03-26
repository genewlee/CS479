//
//  ViewController.swift
//  CommDemo
//
//  Created by Gene Lee on 3/21/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func loginTapped(_ sender: UIButton) {
        let username = self.usernameTextField.text!
        let password = self.passwordTextField.text!
        let jsonStr = "{\"username\":\"\(username)\",\"password\":\"\(password)\"}"
        let jsonData = jsonStr.data(using: .utf8)
        let url = URL(string: "http://www.eecs.wsu.edu/~holder/tmp/login.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = jsonData!
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: handleLoginResponse)
        dataTask.resume()
    }
    
    func handleLoginResponse (data: Data?, response: URLResponse?, error: Error?) {
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
                // respsonse okay, do something with data
                let userId = String(data: data!, encoding: .utf8)
                print("userID = \(userId!)")
            }
        }

    }
    
    func handleResponse (data: Data?, response: URLResponse?, error: Error?) {
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
                // respsonse okay, do something with data
                let dataStr = String(data: data!, encoding: .utf8)
                print("data = \(dataStr!)")
                // response okay, serialize data
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: []) {
                    let jsonDict = jsonObj as! [String: AnyObject]
                    let dateStr = jsonDict["date"] as! String
                    let timeStr = jsonDict["time"] as! String
                    print("\(dateStr) \(timeStr)")
                    DispatchQueue.main.async {
                        self.dateAndTimeLabel.text = "\(dateStr) \(timeStr)"
                    }
                } else {
                    print("error: invalid JSON data")
                }
            }
        }
    }
    
    @IBAction func dateTimeTapped(_ sender: UIButton) {
        let url = URL(string: "http://www.eecs.wsu.edu/~holder/tmp/date.php")
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: handleResponse)
        dataTask.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // getting rid of keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: - News API
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBAction func getNewsTapped(_ sender: UIButton) {
        let url = URL(string: "https://newsapi.org/v1/articles?source=the-verge&sortBy=top&apiKey={cab1685bf263ae0a5adf99f730c518f}")
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: handleNewsResponse)
        dataTask.resume()
    }
    
    func handleNewsResponse (data: Data?, response: URLResponse?, error: Error?) {
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
                // respsonse okay, do something with data
                //let newsStr = String(data: data!, encoding: .utf8)
                //print("data = \(dataStr!)")
                // response okay, serialize data
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: []) {
                    let jsonDict = jsonObj as! [String: AnyObject]
                    let articles = jsonDict["articles"] as! [AnyObject]
                    let articleJSON = articles[0] as! [String: AnyObject]
                    let title = articleJSON["title"] as! String
                    let urlToImage = articleJSON["urlToImage"] as! String
                    DispatchQueue.main.async {
                        self.titleLabel.text = title
                        self.getAndDisplayImage(urlToImage)
                    }
                } else {
                    print("error: invalid JSON data")
                }
            }
        }
    }
    
    func getAndDisplayImage (_ urlToImage: String) {
        let url = URL(string: urlToImage)
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: handleImageResponse)
        dataTask.resume()

    }
    
    func handleImageResponse (data: Data?, response: URLResponse?, error: Error?) {
        let httpResponse = response as! HTTPURLResponse
        let statusCode = httpResponse.statusCode
        if statusCode != 200 {
            let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            print("HTTP \(statusCode) error: \(msg)")
        } else {
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                self.newsImageView.image = image
            }
        }
    }
}

