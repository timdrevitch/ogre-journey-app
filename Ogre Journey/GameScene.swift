//
//  GameScene.swift
//  Ogre Journey
//
//  Created by ogre drev on 10/14/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var touching = false
    private var gameStarted = false
    private var grounds = SKSpriteNode()
    private var swamp = SKSpriteNode()
    private var dildo = SKSpriteNode()
    private var dildo2 = SKSpriteNode()
    private var score = 0
    
    private var scoreboard = SKLabelNode(fontNamed: "Chalkduster")
    
    private var ogre : SKSpriteNode = SKSpriteNode(imageNamed: "ogre")
    private var startLabel : SKSpriteNode = SKSpriteNode(imageNamed: "taptostart")
    private var ground = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5)
        physicsWorld.contactDelegate = self
        
        //add background
        createSwamp()
        
        createDildo()
        createDildo2()
        
        scoreboard.text = String(score)
        scoreboard.fontSize = 80
        scoreboard.zPosition = 8
        scoreboard.fontColor = SKColor.green
        scoreboard.position = CGPoint(x: frame.midX, y: self.frame.size.height / 2.65)
        self.addChild(scoreboard)
        scoreboard.isHidden = true
        
        //add floor
        ground.position = CGPoint(x: 0, y: -(self.frame.size.height / 3) - 100)
        ground.size = CGSize(width: self.frame.size.width * 2, height: 5)
        ground.zPosition = 1
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.allowsRotation = false
        ground.physicsBody?.isDynamic = false
        self.addChild(ground)
        
        //create player
        ogre.position = CGPoint(x: -(self.frame.size.width / 2) + 80, y: 0)
        ogre.size = CGSize(width: 80, height: 80)
        ogre.zPosition = 2
        ogre.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        ogre.physicsBody?.affectedByGravity = false
        ogre.physicsBody?.allowsRotation = false
        ogre.name = "ogre"
        ogre.physicsBody?.contactTestBitMask = ogre.physicsBody?.collisionBitMask ?? 0
        self.addChild(ogre)
        
        //create ground
        createGround()
        
        //Tap to start label
        startLabel.position = CGPoint(x: 0, y: 0)
        startLabel.size = CGSize(width: self.frame.size.width - (self.frame.size.width / 6), height: (self.frame.size.height / 4))
        startLabel.zPosition = 4
        self.addChild(startLabel)
        
        
    }
    
    func collision(between ogre: SKNode, object: SKNode) {
        if object.name == "dildo" {
            score += 1
            scoreboard.text = String(score)
        } else if object.name == "dildo2" {
            //gameStarted = false
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ogre" {
            collision(between: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "ogre" {
            collision(between: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        ogre.physicsBody?.affectedByGravity = true
        ogre.physicsBody?.allowsRotation = true
        
        gameStarted = true
        
        startLabel.isHidden = true
        
        touching = true
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        touching = false
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    func createDildo() {
        dildo = SKSpriteNode(imageNamed: "onion")
        dildo.name = "dildo"
        dildo.size = CGSize(width: 100, height: 100)
        dildo.zPosition = 2
        dildo.position = CGPoint(x: 800, y: Int(arc4random_uniform(UInt32(self.frame.size.height - 100))) - 500)
        self.addChild(dildo)
        dildo.name = "dildo"
        dildo.physicsBody = SKPhysicsBody(circleOfRadius: 45)
        dildo.physicsBody?.affectedByGravity = false
        //dildo.physicsBody?.allowsRotation = false
        dildo.physicsBody?.contactTestBitMask = dildo.physicsBody?.collisionBitMask ?? 0
        //dildo.isHidden = true
    }
    
    func createDildo2() {
        dildo2 = SKSpriteNode(imageNamed: "bomb")
        dildo2.name = "dildo2"
        dildo2.size = CGSize(width: 100, height: 100)
        dildo2.zPosition = 2
        dildo2.position = CGPoint(x: 1300, y: Int(arc4random_uniform(UInt32(self.frame.size.height - 100))) - 510)
        dildo2.physicsBody = SKPhysicsBody(circleOfRadius: 85)
        dildo2.physicsBody?.affectedByGravity = false
        self.addChild(dildo2)
        dildo2.physicsBody = SKPhysicsBody(circleOfRadius: 45)
        dildo2.physicsBody?.affectedByGravity = false
        //dildo.physicsBody?.allowsRotation = false
        dildo2.physicsBody?.contactTestBitMask = dildo2.physicsBody?.collisionBitMask ?? 0
        //dildo2.isHidden = true
    }
    
    func createGround() {
        for i in 0 ... 3 {
            grounds = SKSpriteNode(imageNamed: "grass")
            grounds.name = "grounds"
            grounds.size = CGSize(width: (self.scene?.size.width)!, height: 400)
            grounds.zPosition = 3
            grounds.position = CGPoint(x: CGFloat(i) * grounds.size.width, y: -(self.frame.size.height / 2.5))
            self.addChild(grounds)
        }
    }
    
    func createSwamp() {
        for i in 0 ... 3 {
            swamp = SKSpriteNode(imageNamed: "background")
            swamp.name = "swamp"
            swamp.size = CGSize(width: (self.scene?.size.width)! * 5, height: self.frame.size.height)
            swamp.zPosition = 0
            swamp.position = CGPoint(x: CGFloat(i) * swamp.size.width, y: 0)
            self.addChild(swamp)
        }
    }
    
    func chooseObj() {
        
    }
    
    func moveDildo() {
        self.enumerateChildNodes(withName: "dildo", using: ({
            (node, error) in
            node.position.x -= 4
            if node.position.x < -((self.scene?.size.width)!) / 2 - 50 {
                self.dildo.isHidden = false
                node.position = CGPoint(x: 400, y: (Int(arc4random_uniform(UInt32(self.frame.size.height - 100)))) - 500)
                let rotateAction = SKAction.rotate(byAngle: .pi / 2, duration: 4)
                node.run(rotateAction)
            }
        }))
    }
    
    func moveDildo2() {
        self.enumerateChildNodes(withName: "dildo2", using: ({
            (node, error) in
            node.position.x -= 5
            if node.position.x < -((self.scene?.size.width)!) / 2 - 200 {
                self.dildo2.isHidden = false
                node.position = CGPoint(x: 400, y: (Int(arc4random_uniform(UInt32(self.frame.size.height - 100)))) - 500)
                let rotateAction = SKAction.rotate(byAngle: .pi / 2, duration: 4)
                node.run(rotateAction)
            }
        }))
    }
    
    func moveSwamp() {
        self.enumerateChildNodes(withName: "swamp", using: ({
            (node, error) in
            node.position.x -= 0.5
            if node.position.x < -((self.swamp.size.width)) {
                node.position.x += (self.swamp.size.width) * 3
            }
        }))
    }
    
    func moveGround() {
        self.enumerateChildNodes(withName: "grounds", using: ({
            (node, error) in
            node.position.x -= 2
            if node.position.x < -((self.scene?.size.width)!) {
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
        if gameStarted{
            scoreboard.isHidden = false
            collision(between: ogre, object: dildo)
            //collision(between: ogre, object: dildo2)
            moveGround()
            moveSwamp()
            moveDildo()
            moveDildo2()
            
        }
        
        if touching {
            ogre.physicsBody?.applyForce(CGVector(dx: 0, dy: 200))
        }
        
    }
}
