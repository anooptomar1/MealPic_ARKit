//
//  ViewController.swift
//  MealPicApp_AR
//
//  Created by Zhongheng Li on 9/24/17.
//  Copyright © 2017 MealPicApp. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ScanItemViewController: UIViewController, ARSKViewDelegate {
    
    
    @IBOutlet weak var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        //        if let scene =    SKScene(fileNamed: "Scene") {
        //            sceneView.presentScene(scene)
        //        }
        let scene = Scene(size: sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        
        scene.viewController = self
        sceneView.presentScene(scene)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        //*May be planeDetection would be one of the more important options you can play with inside the configuration object?
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        
        
        
        //        let parentNode = SKNode()
        //        parentNode.position =  SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        //            .horizontalAlignmentMode = .center
        //        parentNode.verticalAlignmentMode = .center
        //
        
        let goodSigh = " 👍"
        let questionSign = " 🤔"
        
        // Create and configure a node for the anchor added to the view's session.
        guard let identifier = ARBridge.shared.anchorsToIdentifiers[anchor] else {
            return nil
        }
        
        let parentNode = SKLabelNode(text: "")
        parentNode.horizontalAlignmentMode = .center
        parentNode.verticalAlignmentMode = .top
        parentNode.name = "selectedItem"
        
        
        let parentPosition = parentNode.position
        
        
        let labelNode = SKLabelNode(text: identifier + goodSigh)
        labelNode.position.x =  parentPosition.x
        labelNode.position.y = parentPosition.y + 150
        labelNode.fontName = UIFont.boldSystemFont(ofSize: 3).fontName
        labelNode.name = "itemNameLabel"
        

        let benefitLabelNode = SKSpriteNode(imageNamed: "BenefitLogo")
        benefitLabelNode.position.x =  parentPosition.x + 50
        benefitLabelNode.position.y =  parentPosition.y + 30
        //benefitLabelNode.setScale(1.5)
        benefitLabelNode.name = "benefitLabel"
        
        let recipeLabelNode = SKSpriteNode(imageNamed: "AlternativeLogo")
        recipeLabelNode.position.x =  parentPosition.x - 80
        recipeLabelNode.position.y =  parentPosition.y + 50
        //recipeLabelNode.setScale(1.5)
        recipeLabelNode.name = "recipeLabel"
        
        let reviewLabelNode = SKSpriteNode(imageNamed: "ReviewLogo")
        reviewLabelNode.position.x =  parentPosition.x + 50
        reviewLabelNode.position.y =  parentPosition.y - 100
        //reviewLabelNode.setScale(1.5)
        reviewLabelNode.name = "reviewLabel"
   
        
        parentNode.addChild(labelNode)
        parentNode.addChild(benefitLabelNode)
        parentNode.addChild(recipeLabelNode)
        parentNode.addChild(reviewLabelNode)
        return parentNode
        
        
        
    }
    
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

