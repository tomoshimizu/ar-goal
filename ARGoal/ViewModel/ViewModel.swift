//
//  ViewModel.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/09.
//

import UIKit
import UserNotifications

class ViewModel: ObservableObject {
    
    @Published var myGoal: String = ""
    @Published var pushHour: Int = Calendar.current.component(.hour, from: Date())
    @Published var pushMinute: Int = Calendar.current.component(.minute, from: Date())
    
    var onSave: () -> Void = { }
    var onLoad: () -> Void = { }
    
    // Push通知を設定
    func setPushNotification() {
        let dateComponents = DateComponents(
            calendar: Calendar.current,
            timeZone: TimeZone.current,
            hour: pushHour,
            minute: pushMinute
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
}

extension ViewModel {
    
//    /// ワールドマップの保存
//    func saveWorldMap() {
//        guard let arView = arView else {
//            return
//        }
//
//        arView.session.getCurrentWorldMap { worldMap, error in
//            guard let worldMap = worldMap else {
//                // TODO: - エラー表示
//                return
//            }
//
//            do {
//                let data = try? NSKeyedArchiver.archivedData(withRootObject: worldMap, requiringSecureCoding: true)
//                try data?.write(to: self.worldMapURL)
//            } catch {
//                fatalError()
//            }
//        }
//    }
//
//    /// ワールドマップの読み込み
//    func loadWorldMap() {
//        guard let arView = arView,
//              let mapData = try? Data(contentsOf: self.worldMapURL),
//              let worldMap = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: mapData) else {
//            fatalError()
//        }
//
//        for anchor in worldMap.anchors {
//            let anchorEntity = AnchorEntity(anchor: anchor)
//            let text = ModelEntity(mesh: MeshResource.generateText("Hello AR",
//                                                                   extrusionDepth: 0.03,
//                                                                   font: .systemFont(ofSize: 0.2),
//                                                                   containerFrame: .zero,
//                                                                   alignment: .center,
//                                                                   lineBreakMode: .byCharWrapping),
//                                   materials: [SimpleMaterial(color: .blue, isMetallic: true)])
//            anchorEntity.addChild(text)
//            arView.scene.addAnchor(anchorEntity)
//        }
//
//        let configuration = ARWorldTrackingConfiguration()
//        configuration.initialWorldMap = worldMap
//        configuration.planeDetection = .horizontal
//
//        arView.session.run(configuration)
//    }
}
