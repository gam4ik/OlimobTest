//
//  GameScene.swift
//  OlimobTest
//
//  Created by Gamid on 29.06.2020.
//  Copyright © 2020 Gamid. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private let sizeOfBarrier = CGSize(width: 60, height: 60)
    private let sizeOfPlatform = CGSize(width: 2000, height: 70)
    private let player = SKShapeNode(circleOfRadius: 50)
    private var didTouchEnable = true
    private var xPositionToMakeNewPlatform: CGFloat = 0
    private var indent = 2000
    
    override func didMove(to view: SKView) {
        SceneSettings()
        setPlayer()
        run(SKAction.repeatForever(
          SKAction.sequence([
            SKAction.run(runPlayer),
            SKAction.wait(forDuration: 1.0)
            ])
        ))
    }
    
    override func update(_ currentTime: TimeInterval) {
        if player.position.x >= xPositionToMakeNewPlatform {
            makeNextPlatform(indent: indent)
            xPositionToMakeNewPlatform += 2000
            indent += 2000
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !didTouchEnable {
            return
        }
        for touch in touches {
            self.touchDown(atPoint: touch.location(in: self))
        }
    }
    
    private func SceneSettings() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)

        let camera = SKCameraNode()
        self.camera = camera
        player.addChild(camera)
    }
    
    private func setPlayer() {
        player.position = CGPoint(x: -900, y: -300)
        player.lineWidth = 10
        player.strokeColor = .orange
        player.fillColor = .blue
        player.name = "Player"
        player.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        self.addChild(player)
    }
    
    private func makeNextPlatform(indent: Int) {
        let roof = makePlatform(indent: indent, yPosition: 0)
        self.addChild(roof)
        
        let floor = makePlatform(indent: indent, yPosition: -500)
        self.addChild(floor)
        
        let xPositionIndent = indent - 1000
        makeBarrier(xPosition: xPositionIndent + 200)
        makeBarrier(xPosition: xPositionIndent + 550)
        makeBarrier(xPosition: xPositionIndent + 700)
        makeBarrier(xPosition: xPositionIndent + 1050)
        makeBarrier(xPosition: xPositionIndent + 1400)
        makeBarrier(xPosition: xPositionIndent + 1650)
        makeBarrier(xPosition: xPositionIndent + 1900)
    }
    
    private func makePlatform(indent: Int, yPosition: Int) -> SKSpriteNode {
        let platform = SKSpriteNode(color: .red, size: sizeOfPlatform)
        platform.position = CGPoint(x: indent, y: yPosition)
        platform.physicsBody = makePhysicsBody(size: sizeOfPlatform)
        return platform
    }
    
    private func makeBarrier(xPosition: Int) {
        let barrier = SKSpriteNode(color: .white, size: CGSize(width: 60, height: 60))
        barrier.position = CGPoint(x: xPosition, y: -435)
        barrier.physicsBody = makePhysicsBody(size: sizeOfBarrier)
        self.addChild(barrier)
    }
    
    private func makePhysicsBody(size: CGSize) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody.isDynamic = false
        return physicsBody
    }
    
    private func runPlayer() {
        let actionMove = SKAction.moveBy(x: 200, y: 0, duration: 1)
        player.run(SKAction.sequence([actionMove]))
    }
    
    private func touchDown(atPoint pos: CGPoint) {
        jump()
    }

    private func jump() {
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
    }
    
}
