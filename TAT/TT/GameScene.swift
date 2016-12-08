//
//  GameScene.swift
//  TT
//
//  Created by Ziwei Yin on 11/30/16.
//  Copyright © 2016 Ziwei Yin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //GameplayKit related
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var lastUpdateTime : TimeInterval = 0

    var rounds = 0
    var w: CGFloat = 0.0
    var h: CGFloat = 0.0
    var map = [[0]]
    var tileWidth: CGFloat = 0.0
    var tileHeight: CGFloat = 0.0
    var enemyPaths = [CGPath]()
    var numEnemy = 0
    let random = GKRandomDistribution(lowestValue: 0, highestValue: 1)
    var play: SKSpriteNode?

    /////////////////weapon related////////////////////////
    var weaponcount: Int = 0
    var weaponname: String = ""
    var weaponimage: String = ""
    var weaponView = UIView()
    var weapon: Weapon = Weapon(t: 0, ori: 0, w: 0.0, h: 0.0)
    
    override func sceneDidLoad() {

        // Initating physicsWorld
        physicsWorld.contactDelegate = self
        
        //Layout background
        w = self.size.width
        h = self.size.height
        tileWidth = w/9
        tileHeight = h/16
        map = [[4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                [0, 3, 3, 2, 2, 2, 3, 2, 2, 2, 3, 3, 3, 3, 3, 0],
                [0, 3, 3, 2, 3, 2, 3, 2, 3, 2, 2, 3, 3, 3, 3, 0],
                [1, 2, 2, 2, 3, 2, 2, 2, 3, 3, 2, 2, 2, 2, 5, 5],
                [0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 5, 5],
                [1, 2, 2, 2, 3, 2, 2, 2, 3, 3, 2, 2, 2, 2, 5, 5],
                [0, 3, 3, 2, 3, 2, 3, 2, 3, 2, 2, 3, 3, 3, 3, 0],
                [0, 3, 3, 2, 2, 2, 3, 2, 2, 2, 3, 3, 3, 3, 3, 0],
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
        makeMap()

        //Init Timer and startGame
        rounds = 0
        enemyPaths = [makePath1(), makePath2()]
        self.isPaused = false
    
        ////////////initializing the weaponview
        weaponView = UIView(frame:CGRect(x:20, y:20, width:w/2 - 40, height:h/2 - 40))
        weaponView.backgroundColor = UIColor(displayP3Red: 134/256, green: 195/256, blue: 201/256, alpha: 1)
        weaponView.layer.borderWidth = 5
        weaponView.layer.borderColor = UIColor.white.cgColor
        self.view?.addSubview(weaponView)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.contactTestBitMask == 0b0001 && contact.bodyB.contactTestBitMask == 0b0010) {
            let enemy = contact.bodyA.node as! Enemy
            let bullet = contact.bodyB.node as! Bullet
            if enemy.hitByBullet(damage: bullet.damage) {
                bullet.run(SKAction.removeFromParent())
                enemy.run(SKAction.removeFromParent())
                numEnemy -= 1
            }
        }
        else if (contact.bodyA.contactTestBitMask == 0b0010 && contact.bodyB.contactTestBitMask == 0b0001) {
            let enemy = contact.bodyB.node as! Enemy
            let bullet = contact.bodyA.node as! Bullet
            if enemy.hitByBullet(damage: bullet.damage) {
                bullet.run(SKAction.removeFromParent())
                enemy.run(SKAction.removeFromParent())
                numEnemy -= 1
            }
        }
        else if (contact.bodyA.contactTestBitMask == 0b0001 && contact.bodyB.contactTestBitMask == 0b0100) {
            let tower = contact.bodyB.node as! Tower
            let enemy = contact.bodyA.node as! Enemy
            if tower.invadeByEnemy(damage: enemy.health) {
                enemy.run(SKAction.removeFromParent())
                numEnemy -= 1
            }
            else {
                lose()
            }
        }
        else if (contact.bodyA.contactTestBitMask == 0b0100 && contact.bodyB.contactTestBitMask == 0b0001) {
            let tower = contact.bodyA.node as! Tower
            let enemy = contact.bodyB.node as! Enemy
            if tower.invadeByEnemy(damage: enemy.health) {
                enemy.run(SKAction.removeFromParent())
                numEnemy -= 1
            }
            else {
                lose()
            }
        }
        else {
        }
    }
    
    func lose() {
        let imageName = "lose.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: w/2, height: h/2)
        self.view?.addSubview(imageView)
    }
    
    
    func sendEnemies() {
        numEnemy += 2
        let enemyType = random.nextInt()
        for i in 0...1 {
            let enemy = Enemy(t: enemyType)
            enemy.run(SKAction.sequence([SKAction.follow((enemyPaths[i]), duration: enemy.sd), SKAction.removeFromParent()]))
            self.addChild(enemy)
        }
    }
    
    func win() {
        let imageName = "win.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: w/2, height: h/2)
        self.view?.addSubview(imageView)
    }

    //////////////////////the weapon selection subview//////////////////////////////////
    func weapon_select() {
        self.isPaused = true
        self.view?.addSubview(weaponView)
        
        // creating the cancel button
        let cancelButton = UIButton(type: UIButtonType.custom) as UIButton
        cancelButton.backgroundColor = UIColor(white: 1, alpha: 0)
        cancelButton.frame = CGRect(x:20 + (h/2 - 40)/3 - 80, y:10, width:40, height:40)
        cancelButton.setImage(UIImage(named: "cancel.png"), for: .normal)
        cancelButton.addTarget(self, action: #selector(GameScene.cancel), for: UIControlEvents.touchDown)
        weaponView.addSubview(cancelButton)
        
        // creating the 1st weapon button
        let firstButton = UIButton(type: UIButtonType.custom) as UIButton
        firstButton.backgroundColor = UIColor(white: 1, alpha: 1)
        firstButton.frame = CGRect(x:20, y:60, width:(h/2 - 40)/3 - 60, height:(h/2 - 40)/3 - 60)
        firstButton.setImage(UIImage(named: "weapon00.png"), for: .normal)
        firstButton.addTarget(self, action: #selector(GameScene.sunflower), for: UIControlEvents.touchDown)
        weaponView.addSubview(firstButton)
        
        // creating the description for weapon 1
        let firstLabel: UILabel = UILabel()
        firstLabel.numberOfLines = 0
        firstLabel.frame = CGRect(x:(h/2 - 40)/3 - 10, y:40, width:w/2 - 40 - (h/2 - 40)/3 - 20, height:(h/2 - 40)/3)
        firstLabel.backgroundColor = UIColor(displayP3Red: 134/256, green: 195/256, blue: 201/256, alpha: 1)
        firstLabel.textColor = UIColor.white
        firstLabel.font = UIFont(name: "Avenir Book", size: 18)
        firstLabel.text = "• Big range bullets\n• Medium damage\n• Shoots 4 directions"
        weaponView.addSubview(firstLabel)
        
        // creating the 2nd weapon button facing up
        let secondButton = UIButton(type: UIButtonType.custom) as UIButton
        secondButton.backgroundColor = UIColor(white: 1, alpha: 1)
        secondButton.frame = CGRect(x:20, y:(h/2 - 40)/3 + 40 , width:(h/2 - 40)/6 - 40, height:(h/2 - 40)/6 - 40)
        secondButton.setImage(UIImage(named: "weapon20.png"), for: .normal)
        secondButton.addTarget(self, action: "ice", for: UIControlEvents.touchDown)
        weaponView.addSubview(secondButton)
        
        // creating the 2nd weapon button facing right
        let secondButton2 = UIButton(type: UIButtonType.custom) as UIButton
        secondButton2.backgroundColor = UIColor(white: 1, alpha: 1)
        secondButton2.frame = CGRect(x:(h/2 - 40)/6, y:(h/2 - 40)/3 + 40, width:(h/2 - 40)/6 - 40, height:(h/2 - 40)/6 - 40)
        secondButton2.setImage(UIImage(named: "weapon21.png"), for: .normal)
        secondButton2.addTarget(self, action: "ice2", for: UIControlEvents.touchDown)
        weaponView.addSubview(secondButton2)
        
        // creating the 2nd weapon button facing down
        let secondButton3 = UIButton(type: UIButtonType.custom) as UIButton
        secondButton3.backgroundColor = UIColor(white: 1, alpha: 1)
        secondButton3.frame = CGRect(x:20, y:(h/2 - 40)/3 + (h/2 - 40)/6 + 20, width:(h/2 - 40)/6 - 40, height:(h/2 - 40)/6 - 40)
        secondButton3.setImage(UIImage(named: "weapon22.png"), for: .normal)
        secondButton3.addTarget(self, action: "ice3", for: UIControlEvents.touchDown)
        weaponView.addSubview(secondButton3)
        
        // creating the 2nd weapon button facing left
        let secondButton4 = UIButton(type: UIButtonType.custom) as UIButton
        secondButton4.backgroundColor = UIColor(white: 1, alpha: 1)
        secondButton4.frame = CGRect(x:(h/2 - 40)/6, y:(h/2 - 40)/3 + (h/2 - 40)/6 + 20, width:(h/2 - 40)/6 - 40, height:(h/2 - 40)/6 - 40)
        secondButton4.setImage(UIImage(named: "weapon23.png"), for: .normal)
        secondButton4.addTarget(self, action: "ice4", for: UIControlEvents.touchDown)
        weaponView.addSubview(secondButton4)
        
        // creating the description for weapon 2
        let secondLabel: UILabel = UILabel()
        secondLabel.numberOfLines = 0
        secondLabel.frame = CGRect(x:(h/2 - 40)/3 - 10, y:(h/2 - 40)/3 + 40, width:w/2 - 40 - (h/2 - 40)/3 - 20, height:(h/2 - 40)/3)
        secondLabel.backgroundColor = UIColor(displayP3Red: 134/256, green: 195/256, blue: 201/256, alpha: 1)
        secondLabel.textColor = UIColor.white
        secondLabel.textAlignment = NSTextAlignment.left
        secondLabel.font = UIFont(name: "Avenir Book", size: 18)
        secondLabel.text = "• High damage\n• Shoots one direction"
        weaponView.addSubview(secondLabel)
        
        /////////////////////////last weapon////////////////////////
        // creating the 3rd weapon button facing up
        let thirdButton = UIButton(type: UIButtonType.custom) as UIButton
        thirdButton.backgroundColor = UIColor(white: 1, alpha: 1)
        thirdButton.frame = CGRect(x:20, y:(h/2 - 40)*2/3 + 20, width:(h/2 - 40)/6 - 40, height:(h/2 - 40)/6 - 40)
        thirdButton.setImage(UIImage(named: "weapon10.png"), for: .normal)
        thirdButton.addTarget(self, action: "gun", for: UIControlEvents.touchDown)
        weaponView.addSubview(thirdButton)
        
        // creating the 3rd weapon button facing right
        let thirdButton2 = UIButton(type: UIButtonType.custom) as UIButton
        thirdButton2.backgroundColor = UIColor(white: 1, alpha: 1)
        thirdButton2.frame = CGRect(x:(h/2 - 40)/6, y:(h/2 - 40)*2/3 + 20, width:(h/2 - 40)/6 - 40, height:(h/2 - 40)/6 - 40)
        thirdButton2.setImage(UIImage(named: "weapon11.png"), for: .normal)
        thirdButton2.addTarget(self, action: "gun2", for: UIControlEvents.touchDown)
        weaponView.addSubview(thirdButton2)
        
        // creating the 3rd weapon button facing down
        let thirdButton3 = UIButton(type: UIButtonType.custom) as UIButton
        thirdButton3.backgroundColor = UIColor(white: 1, alpha: 1)
        thirdButton3.frame = CGRect(x:20, y:(h/2 - 40)*2/3 + (h/2 - 40)/6, width:(h/2 - 40)/6 - 40, height:(h/2 - 40)/6 - 40)
        thirdButton3.setImage(UIImage(named: "weapon12.png"), for: .normal)
        thirdButton3.addTarget(self, action: "gun3", for: UIControlEvents.touchDown)
        weaponView.addSubview(thirdButton3)
        
        // creating the 3rd weapon button facing left
        let thirdButton4 = UIButton(type: UIButtonType.custom) as UIButton
        thirdButton4.backgroundColor = UIColor(white: 1, alpha: 1)
        thirdButton4.frame = CGRect(x:(h/2 - 40)/6, y:(h/2 - 40)*2/3 + (h/2 - 40)/6, width:(h/2 - 40)/6 - 40, height:(h/2 - 40)/6 - 40)
        thirdButton4.setImage(UIImage(named: "weapon13.png"), for: .normal)
        thirdButton4.addTarget(self, action: "gun4", for: UIControlEvents.touchDown)
        weaponView.addSubview(thirdButton4)
        
        // creating the description for weapon 3
        let thirdLabel: UILabel = UILabel()
        thirdLabel.numberOfLines = 0
        thirdLabel.frame = CGRect(x:(h/2 - 40)/3 - 10, y:(h/2 - 40)*2/3, width:w/2 - 40 - (h/2 - 40)/3 - 20, height:(h/2 - 40)/3)
        thirdLabel.backgroundColor = UIColor(displayP3Red: 134/256, green: 195/256, blue: 201/256, alpha: 1)
        thirdLabel.textColor = UIColor.white
        thirdLabel.textAlignment = NSTextAlignment.left
        thirdLabel.font = UIFont(name: "Avenir Book", size: 18)
        thirdLabel.text = "•Straightshot bullets\n• Low damage\n• Shoots one direction"
        weaponView.addSubview(thirdLabel)
    }
    
    /////////////////////////////functions that add weapons///////////////////////////////////////////
    func sunflower() {
        weapon.changeWeapon(t: 0, ori: 0)
        weaponView.removeFromSuperview()
        self.isPaused = false
    }
    func ice() {
        weapon.changeWeapon(t: 2, ori: 0)
        weaponView.removeFromSuperview()
        self.isPaused = false
    }
    func ice2() {
        weapon.changeWeapon(t: 2, ori: 1)
        weaponView.removeFromSuperview()
        self.isPaused = false
    }
    func ice3() {
        weapon.changeWeapon(t: 2, ori: 2)
        weaponView.removeFromSuperview()
        self.isPaused = false
    }
    func ice4() {
        weapon.changeWeapon(t: 2, ori: 3)
        weaponView.removeFromSuperview()
        self.isPaused = false
    }
    func gun() {
        weapon.changeWeapon(t: 1, ori: 0)
        weaponView.removeFromSuperview()
        self.isPaused = false
    }
    func gun2() {
        weapon.changeWeapon(t: 1, ori: 1)
        weaponView.removeFromSuperview()
        self.isPaused = false
    }
    func gun3() {
        weapon.changeWeapon(t: 1, ori: 2)
        weaponView.removeFromSuperview()
        self.isPaused = false
    }
    func gun4() {
        weapon.changeWeapon(t: 1, ori: 3)
        weaponView.removeFromSuperview()
        self.isPaused = false
    }
    func cancel() {
        weapon.removeWeapon()
        weaponView.removeFromSuperview()
        self.isPaused = false
    }
    
    func clickedPlay() {
        if self.isPaused {
            self.isPaused = false
            play?.texture = SKTexture(imageNamed: "pauseButton.jpg")
        }
        else {
            self.isPaused = true
            play?.texture = SKTexture(imageNamed: "playButton.jpg")
        }
    }
    
    /////////////////////////////////////placing a weapon
    func touchDown(atPoint pos : CGPoint) {
        if (play?.contains(pos))! {
            clickedPlay()
        }
        let row = Int(floor((w / 2 - pos.x) / tileWidth))
        let col = Int(floor((h / 2 - pos.y) / tileHeight))
        // may need to change row and col now that we change the orientation to be horizontal
        // if the selected tile is a weapon tile, we display the weapon menu
        if ((row >= 0) && (col >= 0) && (map[row][col] == 3)) {
            let weaponname = "weapon" + String(row) + String(col)
            weapon = self.childNode(withName: weaponname) as! Weapon
            weapon_select()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        let dt = currentTime - self.lastUpdateTime
        if rounds <= 30 {
            if (dt >= 1) {
                rounds += 1
                sendEnemies()
                self.lastUpdateTime = currentTime
            }
        }
        else if rounds <= 60 {
            if (dt >= 0.8) {
                rounds += 1
                sendEnemies()
                self.lastUpdateTime = currentTime
            }
        }
        else if rounds <= 100 {
            if (dt >= 0.5) {
                rounds += 1
                sendEnemies()
                self.lastUpdateTime = currentTime
            }
        }
        else {
            win()
        }
    }
    
    func makeMap() {
        let tileSize = CGSize(width: tileWidth, height: tileHeight)
        let pathColor = UIColor(displayP3Red: 196/256, green: 186/256, blue: 147/256, alpha: 1)
        let gateColor = UIColor(displayP3Red: 175/256, green: 35/256, blue: 28/256, alpha: 1)
        let wallColor = UIColor(displayP3Red: 134/256, green: 195/256, blue: 201/256, alpha: 1)
        let colors = [wallColor, gateColor, pathColor]
        let widthConstant = (-tileWidth / 2) + w / 2
        let heightConstant = (-tileHeight / 2) + h / 2

        //make Tower
        let tower = Tower(tw: tileWidth, th: tileHeight)
        tower.position = CGPoint(x: 0.0, y: (-h/2 + tileHeight))
        self.addChild(tower)
        
        //Make other elements
        for row in 0 ... 8 {
            for col in 0 ... 15 {
                switch map[row][col] {
                case 0:
                    let wall = SKSpriteNode(color: colors[0], size: tileSize)
                    wall.position = CGPoint(x: CGFloat(-row) * tileWidth + widthConstant, y: CGFloat(-col) * tileHeight + heightConstant)
                    wall.name = "wall"
                    self.addChild(wall)
                case 1:
                    let gate = SKSpriteNode(color: colors[1], size: tileSize)
                    gate.position = CGPoint(x: CGFloat(-row) * tileWidth + widthConstant, y: CGFloat(-col) * tileHeight + heightConstant)
                    gate.name = "gate"
                    self.addChild(gate)
                case 2:
                    let path = SKSpriteNode(color: colors[2], size: tileSize)
                    path.position = CGPoint(x: CGFloat(-row) * tileWidth + widthConstant, y: CGFloat(-col) * tileHeight + heightConstant)
                    path.name = "path"
                    self.addChild(path)
                case 3:
                    let emptyWeapon = Weapon(t: 3, ori: 0, w:tileWidth, h: tileHeight)
                    emptyWeapon.position = CGPoint(x: CGFloat(-row) * tileWidth + widthConstant, y: CGFloat(-col) * tileHeight + heightConstant)
                    emptyWeapon.name =  "weapon" + String(row) + String(col)
                    self.addChild(emptyWeapon)
                case 4:
                    let playTexture = SKTexture(imageNamed: "pauseButton")
                    play = SKSpriteNode(texture: playTexture, size: CGSize(width: tileWidth, height: tileHeight))
                    play?.position = CGPoint(x: CGFloat(-row) * tileWidth + widthConstant, y: CGFloat(-col) * tileHeight + heightConstant)
                    self.addChild(play!)
                default:
                    print("")
                }
            }
        }
    }

    func makePath1() -> CGMutablePath {
        let path = CGMutablePath()
        let widthConstant = -tileWidth / 2 + w / 2
        let heightConstant = -tileHeight / 2 + h / 2
        let p0 = CGPoint(x: (-tileWidth * 3) + widthConstant, y: heightConstant)
        let p1 = CGPoint(x: (-tileWidth * 3) + widthConstant, y: (-tileHeight * 3) + heightConstant)
        let p2 = CGPoint(x: (-tileWidth * 1) + widthConstant, y: (-tileHeight * 3) + heightConstant)
        let p3 = CGPoint(x: (-tileWidth * 1) + widthConstant, y: (-tileHeight * 5) + heightConstant)
        let p4 = CGPoint(x: (-tileWidth * 3) + widthConstant, y: (-tileHeight * 5) + heightConstant)
        let p5 = CGPoint(x: (-tileWidth * 3) + widthConstant, y: (-tileHeight * 7) + heightConstant)
        let p6 = CGPoint(x: (-tileWidth * 1) + widthConstant, y: (-tileHeight * 7) + heightConstant)
        let p7 = CGPoint(x: (-tileWidth * 1) + widthConstant, y: (-tileHeight * 9) + heightConstant)
        let p8 = CGPoint(x: (-tileWidth * 2) + widthConstant, y: (-tileHeight * 9) + heightConstant)
        let p9 = CGPoint(x: (-tileWidth * 2) + widthConstant, y: (-tileHeight * 10) + heightConstant)
        let p10 = CGPoint(x: (-tileWidth * 3) + widthConstant, y: (-tileHeight * 10) + heightConstant)
        let p11 = CGPoint(x: (-tileWidth * 3) + widthConstant, y: (-tileHeight * 15) + heightConstant)
        let pts = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11]
        path.move(to: p0)
        for p in pts {
            path.addLine(to: p)
        }
        return path
    }
    
    func makePath2() -> CGMutablePath {
        let path = CGMutablePath()
        let widthConstant = -tileWidth / 2 + w / 2
        let heightConstant = -tileHeight / 2 + h / 2
        let p0 = CGPoint(x: (-tileWidth * 5) + widthConstant, y: heightConstant)
        let p1 = CGPoint(x: (-tileWidth * 5) + widthConstant, y: (-tileHeight * 3) + heightConstant)
        let p2 = CGPoint(x: (-tileWidth * 7) + widthConstant, y: (-tileHeight * 3) + heightConstant)
        let p3 = CGPoint(x: (-tileWidth * 7) + widthConstant, y: (-tileHeight * 5) + heightConstant)
        let p4 = CGPoint(x: (-tileWidth * 5) + widthConstant, y: (-tileHeight * 5) + heightConstant)
        let p5 = CGPoint(x: (-tileWidth * 5) + widthConstant, y: (-tileHeight * 7) + heightConstant)
        let p6 = CGPoint(x: (-tileWidth * 7) + widthConstant, y: (-tileHeight * 7) + heightConstant)
        let p7 = CGPoint(x: (-tileWidth * 7) + widthConstant, y: (-tileHeight * 9) + heightConstant)
        let p8 = CGPoint(x: (-tileWidth * 6) + widthConstant, y: (-tileHeight * 9) + heightConstant)
        let p9 = CGPoint(x: (-tileWidth * 6) + widthConstant, y: (-tileHeight * 10) + heightConstant)
        let p10 = CGPoint(x: (-tileWidth * 5) + widthConstant, y: (-tileHeight * 10) + heightConstant)
        let p11 = CGPoint(x: (-tileWidth * 5) + widthConstant, y: (-tileHeight * 15) + heightConstant)
        let pts = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11]
        path.move(to: p0)
        for p in pts {
            path.addLine(to: p)
        }
        return path
    }
}
