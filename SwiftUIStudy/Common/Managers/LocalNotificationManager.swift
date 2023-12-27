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
    var title: String?
    var subtitile: String?
    var body: String?
    var categoryIdentifier: String?
    var dateComponents: DateComponents?
    var timeInterval: TimeInterval?
    var repeats: Bool
}

struct NotificationActionModel {
    var identifier: String
    var title: String
}

class LocalNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    private let center: UNUserNotificationCenter
    
    override init() {
        center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        super.init()
        center.delegate = self
    }
    
    func scheduleNotification(model: LocalNotificationModel) {
        let content = UNMutableNotificationContent()
        content.title = model.title ?? ""
        content.body = model.body ?? ""
        content.subtitle = model.subtitile ?? ""
        content.categoryIdentifier = model.categoryIdentifier ?? ""
        
        guard let dateComponents = model.dateComponents else { return }
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: model.repeats)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func timeIntervalNotification(model: LocalNotificationModel) {
        let content = UNMutableNotificationContent()
        content.title = model.title ?? ""
        content.body = model.body ?? ""
        content.subtitle = model.subtitile ?? ""
        content.categoryIdentifier = model.categoryIdentifier ?? ""
        
        guard let timeInterval = model.timeInterval else { return }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: model.repeats)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
     
    func notificationActions(categoryIdentifier: String, actionModels: [NotificationActionModel]) {
        var actions = [UNNotificationAction]()
        for model in actionModels {
            actions.append(UNNotificationAction(identifier: model.identifier, title: model.title, options: []))
        }
        
        let category = UNNotificationCategory(
            identifier: categoryIdentifier,
            actions: actions,
            intentIdentifiers: [],
            options: .customDismissAction)

        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "test.state1":
            UserDefaults.standard.setValue("state1", forKey: "pushState")
        case "test.state2":
            UserDefaults.standard.setValue("state2", forKey: "pushState")
        case "test.state3":
            UserDefaults.standard.setValue("state3", forKey: "pushState")
        default:
            break
        }
        completionHandler()
    }
}
