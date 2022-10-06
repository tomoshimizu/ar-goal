//
//  ViewModel.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/09.
//

import SwiftUI

enum WorldMapStatus: String {
    case available = "画面をタップし「保存」を押してください"
    case notAvailable = "カメラをゆっくりと動かしていきましょう\n空間を読み込み中です・・・"
}

class ViewModel: ObservableObject {
    
    /// ARView
    var onSave: () -> Void = { }
    var onClear: () -> Void = { }
    
    @Published var worldMapStatus: WorldMapStatus = .notAvailable
    
    /// 目標
    @Published var myGoal: String = ""
    @Published var isSaved: Bool = false
    
    /// Push通知
    @Published var pushHour: Int = Calendar.current.component(.hour, from: Date())
    @Published var pushMinute: Int = Calendar.current.component(.minute, from: Date())
}
