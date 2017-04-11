//
//  GameScene.swift
//  Bounce
//
//  Created by Gene Lee on 4/8/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var redBallNode: SKSpriteNode!
    var greenBallNode: SKSpriteNode!
    var startStopLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        // Make walls bouncy
        let screenPhysicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        screenPhysicsBody.friction = 0.0
        screenPhysicsBody.categoryBitMask = 0b100
        self.physicsBody = screenPhysicsBody
        
        redBallNode = self.childNode(withName: "redBall") as! SKSpriteNode
        startStopLabel = self.childNode(withName: "StartStop") as! SKLabelNode
        
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
    }
    
    func startGame () {
        self.isPaused = false
        self.startStopLabel.text = "Stop"
        redBallNode.physicsBody?.applyImpulse(CGVector(dx: 200.0, dy: 200.0))
    }
    
    func pauseGame () {
        self.isPaused = true
        self.startStopLabel.text = "Start"
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
        
        // if either of the two bodies is a green ball, then the green ball node is removed from the scene
        if contact.bodyA.node?.name == "greenBall" {
            contact.bodyA.node?.removeFromParent()
        } else if contact.bodyB.node?.name == "greenBall" {
            contact.bodyB.node?.removeFromParent()
        }

    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
