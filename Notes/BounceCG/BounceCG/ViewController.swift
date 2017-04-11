//
//  ViewController.swift
//  BounceCG
//
//  Created by Gene Lee on 4/4/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let frameRate = 30.0 // updates per seconds
    let ballSpeed = 200.0 // points per second
    var ballDirection = CGPoint(x: 1.0, y: -1.0)
    var ballImageView: UIImageView!
    var gameTimer: Timer!
    var gameRunning: Bool = false
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBAction func startStopTapped(_ sender: UIButton) {
        if self.gameRunning {
            self.pauseGame()
        } else {
            self.startGame()
        }
    }
    
    func initGame() {
        let ballImage = UIImage(named: "redball.png")!
        ballImageView = UIImageView()
        ballImageView.image = ballImage
        ballImageView.frame = CGRect(x: 0, y: 0, width: ballImage.size.width, height: ballImage.size.height)
        self.view.addSubview(ballImageView)
        self.gameRunning = false
        self.startStopButton.setTitle("Start", for: .normal)
    }
    
    func startGame () {
        self.gameTimer = Timer.scheduledTimer(withTimeInterval: (1.0 / frameRate), repeats: true, block: updateGame)
        self.gameRunning = true
        self.startStopButton.setTitle("Stop", for: .normal)
    }
    
    func pauseGame () {
        self.gameTimer.invalidate()
        self.gameRunning = false
        self.startStopButton.setTitle("Start", for: .normal)
    }
    
    func updateGame (timer: Timer) {
        let x = self.ballImageView.frame.origin.x
        let y = self.ballImageView.frame.origin.y
        let width = self.ballImageView.frame.width
        let height = self.ballImageView.frame.height
        
        // if ball hits wall, then change direction
        if (x < 0) { // Hit left wall
            self.ballDirection.x = -self.ballDirection.x
        }
        if ((x + width) > self.view.frame.width) { // Hit right wall
            self.ballDirection.x = -self.ballDirection.x
        }
        
        if (y < 0) { // Hit top wall
            self.ballDirection.y = -self.ballDirection.y
        }
        if ((y + height) > self.view.frame.height) { // Hit bottom wall
            self.ballDirection.y = -self.ballDirection.y
        }
        
        // Handle top and bottom walls...
        // Update ball location
        let xOffset = CGFloat(self.ballSpeed / self.frameRate) * self.ballDirection.x
        let yOffset = CGFloat(self.ballSpeed / self.frameRate) * self.ballDirection.y
        self.ballImageView.frame.origin.x = x + xOffset
        self.ballImageView.frame.origin.y = y + yOffset
    }

}

