//
//  GameViewController.swift
//  BounceSceneKit
//
//  Created by Gene Lee on 4/11/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController, SCNPhysicsContactDelegate {
    
    enum WallLocation {
        case back, front, top, bottom, left, right
    }
    
    var redBallNode: SCNNode!
    var startStopTextNode: SCNNode!
    var scene: SCNScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        scene = SCNScene()
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        //  place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 30)

        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)

        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        self.scene.physicsWorld.contactDelegate = self
        
        self.addGeometry()
        self.scene.isPaused = true
//        self.startGame()
    }
    
    func startGame () {
        self.scene.isPaused = false
        let textGeom = startStopTextNode.geometry as! SCNText
        textGeom.string = "Stop"
        redBallNode.physicsBody?.applyForce(SCNVector3(10.0, 9.0, 8.0), asImpulse: true)
        
    }
    
    func pauseGame () {
        self.scene.isPaused = true
        let textGeom = startStopTextNode.geometry as! SCNText
        textGeom.string = "Start"
    }
    
    func addGeometry () {
        // Red ball
        let redBallGeometry = SCNSphere(radius: 1.0)
        let redBallPhysicsShape = SCNPhysicsShape(geometry:redBallGeometry, options: [:])
        redBallGeometry.firstMaterial?.diffuse.contents = UIColor.red
        redBallNode = SCNNode(geometry: redBallGeometry)
        redBallNode.name = "RedBall"
        redBallNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: redBallPhysicsShape)
        redBallNode.physicsBody?.isAffectedByGravity = false
        redBallNode.physicsBody?.friction = 0.0
        redBallNode.physicsBody?.restitution = 1.0
        redBallNode.physicsBody?.damping = 0.0
        redBallNode.physicsBody?.angularDamping = 0.0
        redBallNode.physicsBody?.contactTestBitMask = 0b001 // for contact delegate
        self.scene.rootNode.addChildNode(redBallNode)
        
        // Bounce text
        let bounceTextGeometry = SCNText(string: "Bounce", extrusionDepth: 0.5)
        bounceTextGeometry.firstMaterial!.diffuse.contents = UIColor.lightGray
        let bounceTextNode = SCNNode(geometry: bounceTextGeometry) // Primitive positioning and scaling; could do better
        bounceTextNode.position = SCNVector3(-2.0, 10.0, 0.0)
        bounceTextNode.scale = SCNVector3(0.1, 0.1, 0.1)
        self.scene.rootNode.addChildNode(bounceTextNode)
        
        // Start/Stop text
        let startStopTextGeometry = SCNText(string: "Start", extrusionDepth: 0.5)
        startStopTextGeometry.firstMaterial!.diffuse.contents = UIColor.lightGray
        startStopTextNode = SCNNode(geometry: startStopTextGeometry)
        startStopTextNode.position = SCNVector3(-2.0, -10.0, 0.0)
        startStopTextNode.scale = SCNVector3(0.1, 0.1, 0.1)
        startStopTextNode.name = "StartStop"
        self.scene.rootNode.addChildNode(startStopTextNode)
        
        // Add wals
        self.addWall(.top)
        self.addWall(.bottom)
        self.addWall(.left)
        self.addWall(.right)
        self.addWall(.front)
        self.addWall(.back)
    }
    
    func addWall (_ wallLocation: WallLocation) {
        let wallGeometry = SCNPlane(width: 20.0, height: 20.0)
        wallGeometry.firstMaterial?.diffuse.contents = UIColor.blue // color
        
        // Show walls
        wallGeometry.firstMaterial!.isDoubleSided = true
        wallGeometry.firstMaterial!.diffuse.contents = UIColor.blue
        
        let wallPhysicsShape = SCNPhysicsShape(geometry: wallGeometry, options: [:])
        let wallNode = SCNNode(geometry: wallGeometry)
        wallNode.name = "Wall"
        wallNode.opacity = 0.5 // invisible is 0.0
        wallNode.physicsBody = SCNPhysicsBody(type: .static, shape: wallPhysicsShape)
        wallNode.physicsBody!.friction = 0.0
        wallNode.physicsBody!.restitution = 1.0
        wallNode.physicsBody!.rollingFriction = 0.0
        wallNode.physicsBody?.contactTestBitMask = 0b001 // for contact delegate
        
        
        
        switch wallLocation {
        case .top:
            wallNode.position = SCNVector3(0.0, 10.0, 0.0)
            wallNode.rotation = SCNVector4(1.0, 0.0, 0.0, -Double.pi / 2.0)
        case .bottom:
            wallNode.position = SCNVector3(0.0, -10.0, 0.0)
            wallNode.rotation = SCNVector4(1.0, 0.0, 0.0, -Double.pi / 2.0)
        case .left:
            wallNode.position = SCNVector3(-10.0, 0.0, 0.0)
            wallNode.rotation = SCNVector4(0.0, 1.0, 0.0, -Double.pi / 2.0)
        case .right:
            wallNode.position = SCNVector3(10.0, 0.0, 0.0)
            wallNode.rotation = SCNVector4(0.0, 1.0, 0.0, -Double.pi / 2.0)
        case .front:
            wallNode.position = SCNVector3(0.0, 0.0, 10.0)
            wallNode.opacity = 0.2
        case .back:
            wallNode.position = SCNVector3(0.0, 0.0, -10.0)
        }
        self.scene.rootNode.addChildNode(wallNode)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        let nameA = nodeA.name!
        let nameB = nodeB.name!
        print("contact between \(nameA) and \(nameB)")
    }
    
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        for hitResult in hitResults {
            if (hitResult.node.name == "StartStop") {
//                scnView.isPlaying = !scnView.isPlaying
                if self.scene.isPaused {
                    self.startGame()
                } else {
                    self.pauseGame()
                }
            }
            print("tapped node \(hitResult.node.name!)")
        }
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
