//
//  JokeFuViewController.swift
//  JokerBarBuddy
//
//  Created by Gene Lee on 3/25/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class JokeFuViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    var startPoint: CGPoint!
    var finishPoint: CGPoint!
    let heightLimit: CGFloat = 10.0
    var exceededLimit: Bool = false
    var readyToTry: Bool = true // bool so that cannot try again until tryAgain is tapped
 
    func handlePan (recognizer: UIPanGestureRecognizer) {
        if (self.readyToTry == true) {
            let point = recognizer.location(in: self.view)
            let xi = Int(point.x)
            let yi = Int(point.y)
            if (recognizer.state == .began) {
                print("pan began at (\(xi),\(yi))")
                self.startPoint = point
            }
            if (recognizer.state == .changed) {
                if (point.y > self.startPoint.y + self.heightLimit) || (point.y < self.startPoint.y - self.heightLimit) {
                    self.exceededLimit = true
                }
            }
            if (recognizer.state == .ended) {
                print ("pan ended at (\(xi),\(yi))")
                self.finishPoint = point
                self.verify()
            }
            
            let dotView = UIView(frame: CGRect(x: point.x, y: point.y, width: 5.0, height: 5.0))
            dotView.backgroundColor = UIColor.blue
            dotView.tag = 100
            self.view.addSubview(dotView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.   
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        // remove swipe to go back because interferes with touching from start point
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        
        self.tryButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verify () {
        if (!self.startLabel.frame.contains(self.startPoint)) {
            print("start FAIL")
            self.exceededLimit = true
        }
        if (!self.finishLabel.frame.contains(self.finishPoint)) {
            print("finish FAIL")
            self.exceededLimit = true
        }
        
        if (self.exceededLimit) {
            imageView.image = #imageLiteral(resourceName: "fail.png")
        } else {
            imageView.image = #imageLiteral(resourceName: "pass.png")
        }
        imageView.isHidden = false
        self.tryButton.isHidden = false
        self.readyToTry = false
    }
    
    @IBOutlet weak var tryButton: UIButton!
    @IBAction func tryAgainTapped(_ sender: UIButton) {
        for sub in self.view.subviews {
            if (sub.tag == 100) {
                sub.removeFromSuperview()
            }
        }
        //dotView.removeFromSuperview()
        self.exceededLimit = false // reset
        imageView.isHidden = true
        self.readyToTry = true
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
