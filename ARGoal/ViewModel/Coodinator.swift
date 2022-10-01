//
//  Coodinator.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/28.
//

import Foundation
import ARKit
import RealityKit

class Coordinator: NSObject, ARSessionDelegate {
    
    // MARK: - Variables
    
    let vm: ViewModel
    
    var arView: ARView?
    
    var worldMapURL: URL = {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
            .appendingPathComponent("worldMapURL")
        } catch {
            fatalError("Error getting world map URL from document directory.")
        }
    }()
    
    
    // MARK: - Initializer
    
    init(vm: ViewModel) {
        self.vm = vm
    }
    
    
    // MARK: - Objc Methods
    
    /// 目標を掲げる位置をタップ
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        
        guard let arView = arView else {
            return
        }

        let location = recognizer.location(in: arView)
        let results = arView.raycast(from: location,
                                     allowing: .estimatedPlane,
                                     alignment: .vertical)
        
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
            textModelComp.mesh = .generateText(vm.myGoal,
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
            arView.scene.addAnchor(anchor)
        }
    }
    
    
    // MARK: - Public Methods
    
    /// ワールドマップの保存
    func saveWorldMap() {
        guard let arView = arView else {
            return
        }
        
        arView.session.getCurrentWorldMap { worldMap, error in
            
            guard let map = worldMap else {
                return
            }
            
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: map,
                                                            requiringSecureCoding: true)
                try data.write(to: self.worldMapURL, options: [.atomic])
            } catch {
                fatalError("Can't save map: \(error.localizedDescription)")
            }
        }
    }
    
    /// ワールドマップの読み込み
    func loadWorldMap() {
        guard UserDefaults.standard.bool(forKey: "goalWasSet"),
              let myGoal = UserDefaults.standard.string(forKey: "myGoal"),
              let arView = arView else {
            return
        }
        
        guard let data = try? Data(contentsOf: self.worldMapURL),
              let worldMap = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self,
                                                                    from: data) else {
            return
        }
        
        for anchor in worldMap.anchors {
            let anchorEntity = AnchorEntity(anchor: anchor)

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
            textModelComp.mesh = .generateText(myGoal,
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

            anchorEntity.addChild(textAnchor)
            arView.scene.addAnchor(anchorEntity)
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.initialWorldMap = worldMap
        configuration.planeDetection = [.vertical]
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    /// ワールドマップをクリア
    func clearWorldMap() {
        guard let arView = arView else {
            return
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical
        arView.session.run(configuration,options: [.removeExistingAnchors, .resetTracking])
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "worldMap")
        userDefaults.synchronize()
    }
}
