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
    
    private let player = SKShapeNode(circleOfRadius: 50)
    private var finishBody = SKPhysicsBody()
    private var didTouchEnable = true
    private var isShownFinishLabel = false
    
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
        if player.physicsBody?.allContactedBodies().contains(finishBody) ?? false {
            didTouchEnable = false
            player.removeAllActions()
            showFinishLabel(isShownFinishLabel)
            isShownFinishLabel = true
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
        
        guard let finish = self.childNode(withName: "Finish") as? SKSpriteNode else {
            print("Error with finish")
            return
        }
        guard let finishBody = finish.physicsBody else {
            print("Error with finish body")
            return
        }
        self.finishBody = finishBody

        let camera = SKCameraNode()
        self.camera = camera
        player.addChild(camera)
    }
    
    private func setPlayer() {
        player.position = CGPoint(x: -800, y: -300)
        player.lineWidth = 10
        player.strokeColor = .orange
        player.fillColor = .blue
        player.name = "Player"
        player.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        self.addChild(player)
    }
    
    private func runPlayer() {
        let actionMove = SKAction.moveBy(x: 100, y: 0, duration: 1)
        player.run(SKAction.sequence([actionMove]))
    }
    
    private func touchDown(atPoint pos: CGPoint) {
        jump()
    }

    private func jump() {
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
    }
    
    private func showFinishLabel(_ isShown: Bool) {
        if isShown {
            return
        }
        let finishLabel = SKLabelNode(text: "The End?")
        finishLabel.position = CGPoint(x: 700, y: -100)
        finishLabel.fontSize = 80
        finishLabel.fontColor = .orange
        finishLabel.name = "FinishLabel"
        self.addChild(finishLabel)
    }
}
