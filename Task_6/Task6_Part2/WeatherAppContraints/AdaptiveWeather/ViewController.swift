//
//  ViewController.swift
//  AdaptiveWeather
//
//  Created by Brahmastra on 23/11/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    
 let SnowEmitterNode = SKEmitterNode(fileNamed: "SnowParticleEffects.sks")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSnow()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    private func addSnow()
    {
        
        let skView = SKView(frame: view.frame)
        skView.backgroundColor = .clear
        let scene = SKScene(size: view.frame.size )
        scene.backgroundColor = .clear
        skView.presentScene(scene)
        skView.isUserInteractionEnabled = false
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(SnowEmitterNode)
        SnowEmitterNode.position.y = scene.frame.maxX
        SnowEmitterNode.particlePositionRange.dx = scene.frame.width
        view.addSubview(skView)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

