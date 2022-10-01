//
//  UserNotificationUtil.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/10/01.
//

import UIKit
import UserNotifications

final class UserNotificationUtil: NSObject {
    
    static var shared = UserNotificationUtil()
    
    /// Push通知時間を設定
    func setPushNotification(hour: Int, minute: Int) {
        
        let dateComponents = DateComponents(
            calendar: Calendar.current,
            timeZone: TimeZone.current,
            hour: hour,
            minute: minute
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
