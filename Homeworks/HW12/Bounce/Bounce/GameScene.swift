//
//  GameScene.swift
//  Bounce
//
//  Created by Gene Lee on 4/8/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var viewController: GameViewController?
    
    var redBallNode: SKSpriteNode!
    var greenBallNode: SKSpriteNode!
    var startStopLabel: SKLabelNode!
    var settingsNode: SKSpriteNode!
    
    var bounceSoundAction: SKAction!
    var glassBreakSoundAction: SKAction!
    var audioPlayer: AVAudioPlayer!
    
    override func didMove(to view: SKView) {
        
        // Make walls bouncy
        let screenPhysicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        screenPhysicsBody.node?.name = "wall"
        screenPhysicsBody.friction = 0.0
        screenPhysicsBody.categoryBitMask = 0b100
        screenPhysicsBody.contactTestBitMask = 0b001
        self.physicsBody = screenPhysicsBody
        
        redBallNode = self.childNode(withName: "redBall") as! SKSpriteNode
        startStopLabel = self.childNode(withName: "StartStop") as! SKLabelNode
        settingsNode = self.childNode(withName: "settings") as! SKSpriteNode
        
        physicsWorld.contactDelegate = self
        
        self.initGame()
    }
    
    func initGame () {
        // Add green ball programmatically
        greenBallNode = SKSpriteNode(imageNamed: "green_ball.png")
        greenBallNode.name = "greenBall"
        greenBallNode.physicsBody = SKPhysicsBody(circleOfRadius: 50.0)
        greenBallNode.physicsBody?.affectedByGravity = false
        greenBallNode.physicsBody?.friction = 0.0
        greenBallNode.physicsBody?.restitution = 1.0
        greenBallNode.physicsBody?.linearDamping = 0.0
        greenBallNode.physicsBody?.categoryBitMask = 0b001
        greenBallNode.physicsBody?.collisionBitMask = 0b110
        greenBallNode.physicsBody?.contactTestBitMask = 0b001
        
        bounceSoundAction = SKAction.playSoundFileNamed("bounce.mp3", waitForCompletion: false)
        glassBreakSoundAction = SKAction.playSoundFileNamed("glassbreak.mp3", waitForCompletion: false)
        
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
        
        if (UserDefaults.standard.object(forKey: "backgroundMusic") != nil) {
            if UserDefaults.standard.bool(forKey: "backgroundMusic") {
                audioPlayer.play()
            }
        } else { // there is no UserDefault for background Music, so init to true and play
            UserDefaults.standard.set(true, forKey: "backgroundMusic")
            audioPlayer.play()
        }
    }
    
    func pauseGame () {
        self.isPaused = true
        self.startStopLabel.text = "Start"
        
        if (UserDefaults.standard.object(forKey: "backgroundMusic") != nil) {
            if UserDefaults.standard.bool(forKey: "backgroundMusic") {
                audioPlayer.pause()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = touch.location(in: self)
            let nodeArray = nodes(at: point)
            if nodeArray.count > 0 { // there are nodes at the position
                for node in nodeArray {
                    if node.name == "StartStop" {
                        if (self.isPaused) {
                            self.startGame()
                        } else {
                            self.pauseGame()
                        }
                    } else if node.name == "settings" {
                        self.viewController?.performSegue(withIdentifier: "toSettingsView", sender: self)
                    }
                }
            } else { // nothing at this location -> place a green ball
                if let gn = self.greenBallNode?.copy() as! SKSpriteNode? {
                    // Add green ball programmatically
                    gn.position = point
                    self.addChild(gn)
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyNameA = String(describing: contact.bodyA.node?.name)
        let bodyNameB = String(describing: contact.bodyB.node?.name)
        print("Contact: \(bodyNameA), \(bodyNameB)")
        
        var breakSound = true
        
        if (contact.bodyB.node?.name == "greenBall" && contact.bodyA.node?.name == "greenBall") { // too green balls hit exit out
            return
        } else if contact.bodyB.node?.name == "greenBall" && contact.bodyA.node?.name == "redBall" {
            contact.bodyB.node?.removeFromParent()
        } else if contact.bodyA.node?.name == "greenBall" && contact.bodyB.node?.name == "redBall" {
            contact.bodyA.node?.removeFromParent()
        } else { // hit only other physics body which is the wall/frame
            breakSound = false
        }
        
        // Only pay sound effect if turned on
        if (UserDefaults.standard.object(forKey: "soundEffects") != nil) {
            if UserDefaults.standard.bool(forKey: "soundEffects") {
                if (breakSound) {
                    run(glassBreakSoundAction)
                } else {
                    run(bounceSoundAction)
                }
            }
        } else { // if not set in UserDefaults set it and default to sound effect on
            UserDefaults.standard.set(true, forKey: "soundEffects")
            if (breakSound) {
                run(glassBreakSoundAction)
            } else {
                run(bounceSoundAction)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
