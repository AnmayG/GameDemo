//
//  GameScene.swift
//  GameDemo
//
//  Created by Anmay Gupta on 1/13/22.
//

import Foundation
import SpriteKit
import GameKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Properties
    var player        = SKSpriteNode(imageNamed: "ufo")
    let background    = SKSpriteNode(imageNamed: "blue")
    let stars         = SKEmitterNode(fileNamed: "stars")
    var asteroidTimer = Timer()
    var scoreTimer    = Timer()
    
    let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        anchorPoint = .zero
        physicsWorld.contactDelegate = self
        
        background.position  = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size      = self.size
        background.zPosition = -100
        addChild(background)
        
        stars?.position  = CGPoint(x: size.width / 2, y: size.height / 2)
        stars?.zPosition = 5
        addChild(stars!)
        
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height / 1.1)
        scoreLabel.zPosition = 8
        addChild(scoreLabel)
        score = 0
        
        player.position    = CGPoint(x: size.width / 2, y: size.height / 8)
        player.size        = CGSize(width: 128, height: 128)
        player.zPosition   = 10
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity  = false
        player.physicsBody?.allowsRotation     = false
        player.physicsBody?.categoryBitMask    = 1
        player.physicsBody?.contactTestBitMask = 0
        addChild(player)
        
        asteroidTimer = .scheduledTimer(timeInterval: 1, target: self,
                                        selector:#selector(createAsteroids),
                                        userInfo: nil,
                                        repeats: true)
        
        scoreTimer = .scheduledTimer(timeInterval: 1.5, target: self,
                                     selector:#selector(point),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            player.position.x = location.x
        }
    }
    
    // Create asteroids
    @objc func createAsteroids() {
        // Random X
        let random = GKRandomDistribution(lowestValue: 10, highestValue: 740)
        
        let asteroid         = SKSpriteNode(imageNamed: "meteor-brown-big")
        asteroid.position    = CGPoint(x: random.nextInt(), y: 1400)
        asteroid.zPosition   = 9
        asteroid.size        = CGSize(width: 128, height: 128)
        asteroid.physicsBody = SKPhysicsBody(circleOfRadius: asteroid.size.width/2)
        
        asteroid.physicsBody?.contactTestBitMask = 1
        asteroid.physicsBody?.collisionBitMask   = 0
        addChild(asteroid)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA == player {
            playerRemove(node: nodeA)
        } else {
            playerRemove(node: nodeB)
        }
    }
    
    func playerRemove(node: SKNode) {
        player.removeFromParent()
        gameOver()
    }
    
    func gameOver() {
        let gameOverLabel       = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.position  = CGPoint(x: size.width / 2, y: size.height / 2)
        gameOverLabel.zPosition = 10
        gameOverLabel.text      = "Game Over"
        addChild(gameOverLabel)
        
        let explode = SKEmitterNode(fileNamed: "explode")
        explode?.position = player.position
        addChild(explode!)
    }
    
    @objc func point() {
        score += 1
    }
}
