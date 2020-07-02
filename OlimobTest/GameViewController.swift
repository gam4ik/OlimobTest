//
//  GameViewController.swift
//  OlimobTest
//
//  Created by Gamid on 29.06.2020.
//  Copyright © 2020 Gamid. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import WebKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = AppDelegate.launchURL {
            if let host = url.host {
                let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                guard let url = URL(string: "https://\(host)") else {
                    print("Error with url")
                    return
                }
                let request = URLRequest(url: url)
                webView.load(request)
                self.view.addSubview(webView)
            }
            return
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            view.showsPhysics = true
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
