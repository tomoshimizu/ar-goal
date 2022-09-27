//
//  ARViewContainer.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/15.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {

    @ObservedObject var vm: ViewModel
        
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero,
                            cameraMode: .ar,
                            automaticallyConfigureSession: true)
        
        arView.addTapGesture()

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
    }
}

extension ARView {

    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(tapped(recognizer:)))
        self.addGestureRecognizer(tapGesture)
    }

    @objc func tapped(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        let results = raycast(from: location,
                              allowing: .estimatedPlane,
                              alignment: .any)
        
        // タップした座標に目標を表示
        if let result = results.first {
            
            let anchor = AnchorEntity(raycastResult: result)
            
            // シーンを読み込み
            let textAnchor = try! Experience.loadGoal()

            // テキストを取得
            let textEntity: Entity = textAnchor.myGoal!.children[1].children[0].children[0]
            
            // スケールを設定
            textAnchor.myGoal!.parent!.scale = [1, 1, 1]

            // テキストマテリアルの作成
            var textModelComp: ModelComponent = (textEntity.components[ModelComponent.self])!

            var material = SimpleMaterial()
            material.color = .init(tint: .white, texture: .none)

            textModelComp.materials[0] = material
            textModelComp.mesh = .generateText("Hello",
                                               extrusionDepth: 0.01,
                                               font: UIFont(name: FontName.higaMaruProNW4, size: 0.05)!,
                                               containerFrame: CGRect(),
                                               alignment: .center,
                                               lineBreakMode: .byCharWrapping)
            
            // x=0だと真ん中スタートになるので、テキスト幅/2を-xにずらす
            let textWidth = textModelComp.mesh.bounds.max.x - textModelComp.mesh.bounds.min.x
            textEntity.position = [-textWidth/2, 0, 0]
            
            // オブジェクトを配置
            textAnchor.myGoal!.children[1].children[0].children[0].components.set(textModelComp)
            
            anchor.addChild(textAnchor)
            scene.addAnchor(anchor)
        }
    }
}
