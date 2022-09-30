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
    
    /// Push通知
    @Published var pushHour: Int = Calendar.current.component(.hour, from: Date())
    @Published var pushMinute: Int = Calendar.current.component(.minute, from: Date())
    
    var setPushNotification: () -> Void = { }
    
    
    /// ARView
    @Published var isSaved: Bool = false
    
    var onSave: () -> Void = { }
    var onLoad: () -> Void = { }
}
