//
//  ScanItemViewController.swift
//  MealPic_ARKit
//
//  Created by Zhongheng Li on 9/20/17.
//  Copyright © 2017 Zhongheng Li. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit
import ARKit
import Vision


class ScanItemViewController: UIViewController,ARSCNViewDelegate {
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var dotNodes = [SCNNode]()
    
    var textNodes = [SCNNode]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        
        // Do any additional setup after loading the view.
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        
        
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    func detect(image: CIImage) -> String{
        
        var result = ""
        
        guard let model = try?VNCoreMLModel(for: VGG16().model) else {
            
            fatalError("Faild to load CoreML model")
        }
        
        
        let request = VNCoreMLRequest(model: model){ (request,error) in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                
                fatalError("Model faild to proccess image")
            }

            
            
            if let firstReulst =  results.first{
                
                result = firstReulst.identifier
                
            }
     
        }
        
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            
            try handler.perform([request])
        }
        catch{
            
            print(error)
        }
        
        
        
      
        return result
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
//        
//        let screenSize = videoView.bounds.size
//        
//        if let touchPoint = touches.first {
//            let x = touchPoint.location(in: videoView).y / screenSize.height
//            let y = 1.0 - touchPoint.location(in: videoView).x / screenSize.width
//            let focusPoint = CGPoint(x: x, y: y)
//            
//            if let device = captureDevice {
//                do {
//                    try device.lockForConfiguration()
//                    
//                    device.focusPointOfInterest = focusPoint
//                    //device.focusMode = .continuousAutoFocus
//                    device.focusMode = .autoFocus
//                    //device.focusMode = .locked
//                    device.exposurePointOfInterest = focusPoint
//                    device.exposureMode = AVCaptureExposureMode.continuousAutoExposure
//                    device.unlockForConfiguration()
//                }
//                catch {
//                    // just ignore
//                }
//            }
//        }
//        
        
        
        
        
        var resultString = ""
        
        if dotNodes.count >= 2 {
            
            for dot in dotNodes {
                
                dot.removeFromParentNode()
            }
            
            dotNodes = [SCNNode]()
            
            
            
        }
        
        // Capture Images Selection
        
        
        
//        let screenCentre : CGPoint = CGPoint(x: self.sceneView.bounds.midX, y: self.sceneView.bounds.midY)
//
//
        
        if let touchLocation = touches.first?.location(in: sceneView){
            
            let hitTestResult = sceneView.hitTest(touchLocation, types: .featurePoint)
            
            if let hitResult = hitTestResult.first{
                
                
                let thisImage = sceneView.snapshot()
                
                guard let ciimage = CIImage(image: thisImage) else {
                    
                    fatalError("App can not convert UIImage into CIImage")
                }
                
                resultString = detect(image: ciimage)
                
                
                addDot(at: hitResult, labelText: resultString)
                
            }
        }
        
        
 
    }
    
    
    func addDot(at hitResult: ARHitTestResult, labelText: String){
        
        let dotGeometry = SCNSphere(radius: 0.005)
        
        let materials = SCNMaterial()
        
        materials.diffuse.contents = UIColor.red
        
        dotGeometry.materials = [materials]
        
        let dotNode = SCNNode(geometry: dotGeometry)
        
        dotNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        
        sceneView.scene.rootNode.addChildNode(dotNode)
        
        dotNodes.append(dotNode)
        
        
        updateText(text: labelText, atPosition: dotNode.position)

        
    }
    
    
    func updateText(text: String, atPosition position: SCNVector3){
        
        
        if textNodes.count >= 2 {
            
            for text in textNodes {
                
                text.removeFromParentNode()
            }
            
            textNodes = [SCNNode]()
            
        }
        
        
        //textNodes.removeFromParentNode()
        
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        
        textGeometry.firstMaterial?.diffuse.contents = UIColor.blue
        
        let textNode = SCNNode(geometry: textGeometry)
        
        textNode.position = SCNVector3(position.x, position.y + 0.01, position.z )
        
        textNode.scale  = SCNVector3(0.005, 0.005, 0.005)
        
        textNodes.append(textNode)
        
        sceneView.scene.rootNode.addChildNode(textNode)
        
    }
    
    
}
