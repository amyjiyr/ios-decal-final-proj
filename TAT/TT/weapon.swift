//
//  weapon.swift
//  TT
//
//  Created by Ziwei Yin on 12/1/16.
//  Copyright © 2016 Ziwei Yin. All rights reserved.
//

import Foundation
import SpriteKit

class Weapon: SKSpriteNode {

    var orientation = 4
    var type = 3
    var timer = Timer()
    var tw = CGFloat(0.0)
    var th = CGFloat(0.0)

    init(t: Int, ori: Int, w: CGFloat, h: CGFloat) {
        let c = UIColor(displayP3Red: 241/256, green: 231/256, blue: 228/256, alpha: 1)
        super.init(texture: nil, color: c, size: CGSize(width: w, height: h))
        self.zPosition = CGFloat(50.0)
    }
    
    func changeWeapon(t: Int, ori: Int)  {
        type = t
        orientation = ori
        switch type {
        case 0:
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(Weapon.fireWeapon0),userInfo: nil, repeats: true)
        case 1:
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Weapon.fireWeapon1),userInfo: nil, repeats: true)
        case 2:
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(Weapon.fireWeapon2),userInfo: nil, repeats: true)
        default:
            timer = Timer()
        }
        let image = "weapon" + String(t) + String(ori) + ".png"
        let texture = SKTexture(imageNamed: image)
        self.texture = texture
        //self.color = UIColor.clear
    }

    
    func fireWeapon0() {
        let bullets = [Bullet(t: 0, ori: 0), Bullet(t: 0, ori: 1), Bullet(t: 0, ori: 2), Bullet(t: 0, ori: 3)]
        let actions = [SKAction.move(by: CGVector(dx: 0, dy: -200), duration: bullets[0].sd),
                       SKAction.move(by: CGVector(dx: 200, dy: 0), duration: bullets[0].sd),
                       SKAction.move(by: CGVector(dx: 0, dy: 200), duration: bullets[0].sd),
                       SKAction.move(by: CGVector(dx: -200, dy: 0), duration: bullets[0].sd)]
        for i in 0...3 {
            bullets[i].run(SKAction.sequence([actions[i], SKAction.removeFromParent()]))
            self.addChild(bullets[i])
        }
    }

    func fireWeapon1() {
        let bullet = Bullet(t: 1, ori: orientation)
        self.addChild(bullet)
        switch orientation {
        case 0:
            bullet.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: -1000), duration: bullet.sd), SKAction.removeFromParent()]))
        case 1:
            bullet.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 1000, dy: 0), duration: bullet.sd), SKAction.removeFromParent()]))
        case 2:
            bullet.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: 1000), duration: bullet.sd), SKAction.removeFromParent()]))
        case 3:
            bullet.run(SKAction.sequence([SKAction.move(by: CGVector(dx: -1000, dy: 0), duration: bullet.sd), SKAction.removeFromParent()]))
        default:
            bullet.removeFromParent()
        }
    }
    
    func fireWeapon2() {
        let bullet = Bullet(t: 2, ori: orientation)
        self.addChild(bullet)
        switch orientation {
        case 0:
            bullet.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: -250), duration: bullet.sd), SKAction.removeFromParent()]))
        case 1:
            bullet.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 250, dy: 0), duration: bullet.sd), SKAction.removeFromParent()]))
        case 2:
            bullet.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: 250), duration: bullet.sd), SKAction.removeFromParent()]))
        case 3:
            bullet.run(SKAction.sequence([SKAction.move(by: CGVector(dx: -250, dy: 0), duration: bullet.sd), SKAction.removeFromParent()]))
        default:
            bullet.removeFromParent()
        }
    }

    func removeWeapon() {
        orientation = 3
        type = 3
        timer.invalidate()
        self.texture = nil
        self.color = UIColor(displayP3Red: 241/256, green: 231/256, blue: 228/256, alpha: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        // Decoding length here would be nice...
        super.init(coder: aDecoder)
    }
}
