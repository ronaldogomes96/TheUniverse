//
//  3DViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 27/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class Image3DViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    private let node = SCNNode()
    var viewModel: Image3DViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        nodeConfiguration()
        sceneViewSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }

    private func nodeConfiguration() {
        let sphere = SCNSphere(radius: 0.4)

        let materials = SCNMaterial()
        materials.diffuse.contents = UIImage(named: "Assets.scnassets/3DPlanets/\(viewModel?.getAssertName() ?? "")")

        sphere.materials = [materials]

        node.position = SCNVector3(0, 0.1, -2)
        node.geometry = sphere

        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(0, 1, 0), duration: 15)
        let repeatAction = SCNAction.repeatForever(action)

        node.runAction(repeatAction)
    }

    private func sceneViewSetup() {
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        sceneView.scene.rootNode.addChildNode(node)
    }
}
