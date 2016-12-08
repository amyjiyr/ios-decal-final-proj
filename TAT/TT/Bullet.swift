//
//  Bullet.swift
//  TT
//
//  Created by Ziwei Yin on 12/2/16.
//  Copyright © 2016 Ziwei Yin. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode {
    
    var damage = 0
    var sd = 0.0
    var type = 0
    var orientation = 0
    
    init(t: Int, ori: Int) {
        type = t
        orientation = ori
        let name = String(type) + String(ori)
        let texture = SKTexture(imageNamed: "bullet" + name + ".png")
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 50, height: 50))
        self.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 0b0010
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.zPosition = 80.0
        self.physicsBody?.mass = CGFloat(0.0)
        self.physicsBody?.collisionBitMask = 0


        switch t {
        case 0:
            damage = 2
            sd = 2.0
        case 1:
            damage = 6
            sd = 10.0
        case 2:
            damage = 1
            sd = 1.0
        default:
            damage = 0
        }
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        // Decoding length here would be nice...
        super.init(coder: aDecoder)
    }
}
