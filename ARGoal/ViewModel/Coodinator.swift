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
    
    let vm: ViewModel
    var arView: ARView?
    
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
                                     alignment: .any)
        
        // タップした座標に目標を表示
        if let result = results.first {
            let anchor = AnchorEntity(raycastResult: result)
            placeMyGoal(arView: arView, anchorEntity: anchor)
        }
    }
    
    
    // MARK: - Public Methods
    
    /// ワールドマップの保存
    func saveWorldMap() {
        guard let arView = arView else {
            return
        }

        arView.session.getCurrentWorldMap { [weak self] worldMap, error in
            
            if error != nil {
                return
            }
            
            if let worldMap = worldMap {
                guard let data = try? NSKeyedArchiver.archivedData(withRootObject: worldMap,
                                                                   requiringSecureCoding: true) else {
                    return
                }
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(data, forKey: "worldMap")
                userDefaults.synchronize()
                
                self?.vm.isSaved = true
            }
        }
    }
    
    /// ワールドマップの読み込み
    func loadWorldMap() {
        guard let arView = arView else {
            return
        }
        
        if let data = UserDefaults.standard.data(forKey: "worldMap") {
            
            guard let worldMap = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self,
                                                                         from: data) else {
                return
            }
            
            for anchor in worldMap.anchors {
                let anchorEntity = AnchorEntity(anchor: anchor)
                placeMyGoal(arView: arView, anchorEntity: anchorEntity)
            }
            
            let configuration = ARWorldTrackingConfiguration()
            configuration.initialWorldMap = worldMap
            configuration.planeDetection = .vertical
            
            arView.session.run(configuration)
        }
    }
    
    /// ワールドマップをクリア
    func clearWorldMap() {
        guard let arView = arView else {
            return
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration,options: [.removeExistingAnchors, .resetTracking])
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "worldMap")
        userDefaults.synchronize()
        
        vm.isSaved = false
    }
    
    /// Push通知時間を設定
    func setPushNotification() {
        let dateComponents = DateComponents(
            calendar: Calendar.current,
            timeZone: TimeZone.current,
            hour: vm.pushHour,
            minute: vm.pushMinute
        )
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let content = UNMutableNotificationContent()
        content.title = Message.pushTitle
        content.body = Message.pushBody
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    
    // MARK: - Private Methods
    
    private func placeMyGoal(arView: ARView, anchorEntity: AnchorEntity) {
        
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
        
        if let anchor = anchorEntity.anchor {
            anchor.addChild(textEntity)
            arView.scene.addAnchor(anchor)
        }
    }
}
