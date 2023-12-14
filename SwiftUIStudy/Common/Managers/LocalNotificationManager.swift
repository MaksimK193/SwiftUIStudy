//
//  LocalNotificationManager.swift
//  SwiftUIStudy
//
//  Created by USER on 14.12.2023.
//

import Foundation
import UserNotifications

struct LocalNotificationModel {
    var identifier: String
    var title: String
    var subtitile: String
    var body: String
    var dateComponents: DateComponents
    var repeats: Bool
}

class LocalNotificationManager {
    private let center: UNUserNotificationCenter
    
    init() {
        center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleNotification(model: LocalNotificationModel) {
        let content = UNMutableNotificationContent()
        content.title = model.title
        content.body = model.body
        content.subtitle = model.subtitile
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: model.dateComponents, repeats: model.repeats)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
