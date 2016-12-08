//
//  Enemy.swift
//  TT
//
//  Created by Ziwei Yin on 12/2/16.
//  Copyright © 2016 Ziwei Yin. All rights reserved.
//

import Foundation
import SpriteKit


class Enemy: SKSpriteNode {

    var type = 0
    var health = 0
    var sd = 0.0
    
    init(t: Int) {
        type = t
        let texture = SKTexture(imageNamed: "enemy" + String(type))
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 80, height: 80))
        self.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 0b0001
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.mass = CGFloat(0.0)
        self.physicsBody?.collisionBitMask = 0
        switch t {
        case 0:
            health = 8
            sd = 10.0
        case 1:
            health = 6
            sd = 6.0
        case 2:
            health = 3
            sd = 4.0
        default:
            health = 0
        }
    }
    
    func hitByBullet(damage: Int) -> Bool{
        health -= damage
        if health <= 0 {
            return true
        }
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        // Decoding length here would be nice...
        super.init(coder: aDecoder)
    }
}
