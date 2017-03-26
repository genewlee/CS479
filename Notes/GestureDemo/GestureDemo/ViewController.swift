//
//  ViewController.swift
//  GestureDemo
//
//  Created by Gene Lee on 2/28/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueVIew: UIView!
    
    @IBAction func tapDetected (recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: self.view)
        let xi = Int(point.x)
        let yi = Int(point.y)
        print("tap detected at (\(xi),\(yi))")
    }
    
    @IBAction func redTapDetected (recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: self.redView) // x and y within redView // self.view will be relative to the viewController itself -> or the parent view
        let xi = Int(point.x)
        let yi = Int(point.y)
        print("red tap detected at (\(xi),\(yi))")
    }
    
    @IBAction func blueTapDetected (recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: self.blueVIew)
        let xi = Int(point.x)
        let yi = Int(point.y)
        print("blue tap detected at (\(xi),\(yi))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let redTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(redTapDetected))
        self.redView.addGestureRecognizer(redTapGestureRecognizer)
        
        let blueTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(blueTapDetected))
        self.blueVIew.addGestureRecognizer(blueTapGestureRecognizer)
        
        // adding views to this viewcontroller
        self.view.addSubview(redView)
        self.view.addSubview(blueVIew)
        
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        panGestureRecognizer.delegate = self
//        self.view.addGestureRecognizer(panGestureRecognizer)
        
        let twoTouchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTwoTouch))
        twoTouchGestureRecognizer.delegate = self
        twoTouchGestureRecognizer.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoTouchGestureRecognizer)
        
        // ZORRO
        let zorroGestureRecognizer = ZorroGestureRecognizer()
        zorroGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(zorroGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    func handlePan (recognizer: UIPanGestureRecognizer) {
        let point = recognizer.location(in: self.view)
        let xi = Int(point.x)
        let yi = Int(point.y)
        if (recognizer.state == .began) {
            print("pan began at (\(xi),\(yi))")
        }
        if (recognizer.state == .changed) {
            print ("pan moved to (\(xi),\(yi))")
        }
        if (recognizer.state == .ended) {
            print ("pan ended at (\(xi),\(yi))")
        }
    }*/
    
    func handleTwoTouch (recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: self.view)
        let x = Int(point.x)
        let y = Int(point.y)
        print("two touch detected at (\(x),\(y))")
    }
}

