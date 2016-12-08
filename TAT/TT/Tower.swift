//
//  Tower.swift
//  TT
//
//  Created by Ziwei Yin on 12/3/16.
//  Copyright © 2016 Ziwei Yin. All rights reserved.
//

import Foundation
import SpriteKit


class Tower: SKSpriteNode {
    var health = 0

    init(tw: CGFloat, th: CGFloat) {
        health = 90
        let texture = SKTexture(imageNamed: "Tower.png")
        // makes the width and height
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 2 * tw, height: 2 * th))
        self.physicsBody = SKPhysicsBody(circleOfRadius: tw)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 0b0100
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.mass = CGFloat(0.0)
        self.physicsBody?.collisionBitMask = 0

    }

    func invadeByEnemy(damage: Int) -> Bool{
        health -= damage
        if (health <= 0) {
            return false
        }
        else if (health <= 30) {
            self.texture = SKTexture(imageNamed: "Tower1.png")
            return true
        }
        else if (health <= 60) {
            return true
            self.texture = SKTexture(imageNamed: "tower2.png")
        }
        else {
            return true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
