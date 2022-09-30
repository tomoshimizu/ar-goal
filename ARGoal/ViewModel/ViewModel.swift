//
//  ViewModel.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/09.
//

import UIKit
import UserNotifications

class ViewModel: ObservableObject {
    
    /// ARView
    @Published var isSaved: Bool = false
    
    var onSave: () -> Void = { }
    var onLoad: () -> Void = { }
    
    /// 目標
    @Published var myGoal: String = ""
    
    /// Push通知
    @Published var pushHour: Int = Calendar.current.component(.hour, from: Date())
    @Published var pushMinute: Int = Calendar.current.component(.minute, from: Date())
    
    
    /// Push通知時間を設定
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
