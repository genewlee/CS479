//
//  GameScene.swift
//  BounceSpriteKit2
//
//  Created by Larry Holder on 4/4/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var redBallNode: SKSpriteNode!
    var greenBallNode: SKSpriteNode!
    var startStopLabel: SKLabelNode!
    
    var bounceSoundAction: SKAction!
    var audioPlayer: AVAudioPlayer!
    
    override func didMove(to view: SKView) {
        
        // Make walls bouncy
        let screenPhysicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        screenPhysicsBody.friction = 0.0
        screenPhysicsBody.categoryBitMask = 0b100
        self.physicsBody = screenPhysicsBody
        
        redBallNode = self.childNode(withName: "RedBall") as! SKSpriteNode
        startStopLabel = self.childNode(withName: "StartStop") as! SKLabelNode
        
        physicsWorld.contactDelegate = self
        
        self.initGame()
    }
    
    func initGame () {
        // Add green ball programmatically
        greenBallNode = SKSpriteNode(imageNamed: "greenball.png")
        greenBallNode.name = "GreenBall"
        greenBallNode.physicsBody = SKPhysicsBody(circleOfRadius: 50.0)
        greenBallNode.physicsBody?.affectedByGravity = false
        greenBallNode.physicsBody?.friction = 0.0
        greenBallNode.physicsBody?.restitution = 1.0
        greenBallNode.physicsBody?.linearDamping = 0.0
        greenBallNode.physicsBody?.categoryBitMask = 0b001
        greenBallNode.physicsBody?.collisionBitMask = 0b110
        greenBallNode.physicsBody?.contactTestBitMask = 0b001
        self.addChild(greenBallNode)
        
        bounceSoundAction = SKAction.playSoundFileNamed("bounce.mp3", waitForCompletion: false)
        
        let musicURL = Bundle.main.url(forResource: "WSU-Fight-Song.mp3", withExtension: nil)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicURL!)
        } catch {
            print("error accessing music")
        }
        audioPlayer.volume = 0.25
        audioPlayer.numberOfLoops = -1 // loop forever
    }
    
    func startGame () {
        self.isPaused = false
        self.startStopLabel.text = "Stop"
        redBallNode.physicsBody?.applyImpulse(CGVector(dx: 200.0, dy: 200.0))
        
        audioPlayer.play() // In startGame()
    }
    
    func pauseGame () {
        self.isPaused = true
        self.startStopLabel.text = "Start"
        
        audioPlayer.pause() // In pauseGame()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = touch.location(in: self)
            let nodeArray = nodes(at: point)
            for node in nodeArray {
                if node.name == "StartStop" {
                    if (self.isPaused) {
                        self.startGame()
                    } else {
                        self.pauseGame()
                    }
                }
            }
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node!
        let nodeB = contact.bodyB.node!
        let bodyNameA = String(describing: contact.bodyA.node?.name)
        let bodyNameB = String(describing: contact.bodyB.node?.name)
        print("Contact: \(bodyNameA), \(bodyNameB)")
//        let blinkAction = SKAction.init(named: "blink")!
//        nodeA.run(blinkAction)
//        nodeB.run(blinkAction)
        let action1 = SKAction.fadeOut(withDuration: 0.25)
        let action2 = SKAction.fadeIn(withDuration: 0.25)
        let blinkAction = SKAction.sequence([action1,action2])
        nodeA.run(blinkAction)
        nodeB.run(blinkAction)
        
        run(bounceSoundAction)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
