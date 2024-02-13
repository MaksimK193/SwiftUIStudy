//
//  NotificationActionsView.swift
//  SwiftUIStudy
//
//  Created by USER on 26.12.2023.
//

import SwiftUI
import UserNotifications
import YandexMobileMetrica

struct NotificationActionsView: View {
    let localNotificationManager: LocalNotificationManager
    
    var body: some View {
        Text("Notification Actions")
            .onAppear {
                YMMYandexMetrica.reportEvent("NotificationActionsScreen opened")
            }
    }
    
    init(localNotificationManager: LocalNotificationManager) {
        self.localNotificationManager = localNotificationManager
        notification()
    }
    
    func notification() {
        let notificationModel = LocalNotificationModel(identifier: "test",
                                                       title: "Test",
                                                       categoryIdentifier: "test",
                                                       timeInterval: 10,
                                                       repeats: false)
        
        let actionModels = [NotificationActionModel(identifier: "test.state1", title: "State1"),
                            NotificationActionModel(identifier: "test.state2", title: "State2"),
                            NotificationActionModel(identifier: "test.state3", title: "State3")]
        
        localNotificationManager.timeIntervalNotification(model: notificationModel)
        localNotificationManager.notificationActions(categoryIdentifier: "test", actionModels: actionModels)
    }
}

#Preview {
    NotificationActionsView(localNotificationManager: LocalNotificationManager())
}
