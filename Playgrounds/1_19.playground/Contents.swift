//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum Direction {
    case up // does not imply .up = 0 
    case left
    case down
    case right
}

var playerDirection = Direction.right
playerDirection = .up // type inference

func turnLeft (direction: Direction) -> Direction {
    var newDirection: Direction
    
    switch playerDirection {
    case .up: newDirection = .left
    case .left: newDirection = .down
    case .down: newDirection = .right
    case .right: newDirection = .up
    }
    return newDirection
}

class Player {
    var direction: Direction
    var speed: Float
    var inventory: [String]? // initialized to nil
    init (speed: Float, direction: Direction) { self.speed = speed
        self.direction = direction
    }
    
    func energize() {
        speed += 1.0
    }
}

var player = Player(speed: 1.0, direction: .right)

class FlyingPlayer : Player {
    var altitude: Float
    
    init (speed: Float, direction: Direction, altitude: Float) {
        self.altitude = altitude
        super.init (speed: speed, direction: direction)
    }
    
    override func energize() {
        super.energize()
        altitude += 1.0
    }
}

//Must initialize all non- optional child properties before initializing parent.

var flyingPlayer = FlyingPlayer(speed: 1.0, direction: .right, altitude: 1.0)

print(flyingPlayer.altitude)
flyingPlayer.energize()
print(flyingPlayer.altitude)

type(of: flyingPlayer)

let a:Int
let b:Int?
let c:Int!

var xarray = [String]()
xarray.append("Test")
print(xarray.first!)

