//
//  ViewController.swift
//  AR kit demo
//
//  Created by Benja Muñoz  on 8/6/18.
//  Copyright © 2018 Benja Munoz. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addBox()
        addTapGestureToSceneView()
    }
    
    //Se especifica comportamiento de la app al verse, dejarse en background
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)  //se revisa si la ubicación del tap es logica para la scene en cuestion
        guard let node = hitTestResults.first?.node  // ARkit revisa si encuentra superficies sobre las cuales ubicar objetos, "hits". Se usa la primera que encontremos
            else {
                let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint) // Searches for real-world objects or AR anchors

                if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                    let translation = hitTestResultWithFeaturePoints.worldTransform.translation
                    addBox(x: translation.x, y: translation.y, z: translation.z)
                }
                return }
        node.removeFromParentNode()
    }
    
    func addBox(x: Float = 0, y: Float = 0.05, z: Float = -0.2) {
        //Box es un objeto, con medidas en metros
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        //Nodo es un punto en el espacio que por si solo no tiene visibilidad
        let boxNode = SCNNode()
        boxNode.geometry = box
        
        //Positive x is to the right. Negative x is to the left. Positive y is up. Negative y is down. Positive z is backward. Negative z is forward.
        boxNode.position = SCNVector3(x, y, z)
        
        let scene = SCNScene()
        
        //root node define el origen del sistema de coordenadas
        scene.rootNode.addChildNode(boxNode)
        sceneView.scene = scene
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBOutlet weak var sceneView: ARSCNView!
    

}

//transforma data matricial desde AR kit a un vector
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

