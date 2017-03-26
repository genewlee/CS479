//
//  ZorroGestureRecognizer.swift
//  GestureDemo
//
//  Created by Gene Lee on 3/2/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class ZorroGestureRecognizer: UIGestureRecognizer {
    
    var startPoint: CGPoint!
    var leftTurnPoint: CGPoint!
    var rightTurnPoint: CGPoint!
    var endPoint: CGPoint!
    var firstLeg = false
    var secondLeg = false
    var thirtLeg = false
    var lastPoint: CGPoint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        print("zorro touchesBegan")
        startPoint = touches.first?.location(in: self.view) // self.view is the main view that this is being called from
        firstLeg = true
        lastPoint = startPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        //print("zorro touchesMoved")
        let currentPoint = touches.first?.location(in: self.view)
        if firstLeg {
            if (currentPoint!.x < lastPoint.x) {
                // left turn detected
                firstLeg = false
                secondLeg = true
                leftTurnPoint = lastPoint
                print("made it to second leg")
            }
        } else if secondLeg {
            if (currentPoint!.x > lastPoint.x) {
                secondLeg = false
                thirtLeg = true
                rightTurnPoint = lastPoint
            }
        }
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        print("zorro touchesEnded")
        endPoint = touches.first?.location(in: self.view)
        if thirtLeg {
            print("got to the third leg")
            state = .recognized
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        print("zorro touchesCancelled")
    }
    
    override func reset() {
        print("zorro reset")
        firstLeg = false
        secondLeg = false
        thirtLeg = false
    }
}
