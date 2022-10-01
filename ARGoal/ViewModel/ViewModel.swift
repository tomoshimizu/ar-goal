//
//  ViewModel.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/09.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    /// ARView
    var onSave: () -> Void = { }
    var onClear: () -> Void = { }
    
    /// 目標
    @Published var myGoal: String = ""
    
    /// Push通知
    @Published var pushHour: Int = Calendar.current.component(.hour, from: Date())
    @Published var pushMinute: Int = Calendar.current.component(.minute, from: Date())
}
