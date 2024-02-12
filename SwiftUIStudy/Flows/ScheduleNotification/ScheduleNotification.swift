//
//  ScheduleNotification.swift
//  SwiftUIStudy
//
//  Created by USER on 13.12.2023.
//

import SwiftUI
import YandexMobileMetrica

struct ScheduleNotification: View {
    @State private var notificationDate = Date.now
    @State private var notificationText = ""
    let localNotificationManager: LocalNotificationManager
    
    var body: some View {
        VStack {
            DatePicker("", selection: $notificationDate, in: Date.now...)
                .labelsHidden()
            TextField(L10n.ScheduleNotification.TextField.notificationText, text: $notificationText)
                .textFieldStyle(.roundedBorder)
            Button(L10n.ScheduleNotification.Button.scheduleNotification) {
                scheduleNotification()
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: 190)
        .onAppear {
            YMMYandexMetrica.reportEvent("ScheduleNotificationScreen opened")
        }
    }
    
    func scheduleNotification() {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        
        let model = LocalNotificationModel(identifier: UUID().uuidString,
                                           title: "Schedule notification",
                                           body: notificationText,
                                           dateComponents: components,
                                           repeats: false)
        
        localNotificationManager.scheduleNotification(model: model)
    }
}

#Preview {
    ScheduleNotification(localNotificationManager: LocalNotificationManager())
}
