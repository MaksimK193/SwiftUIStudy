//
//  ScheduleNotification.swift
//  SwiftUIStudy
//
//  Created by USER on 13.12.2023.
//

import SwiftUI

struct ScheduleNotification: View {
    @State private var notificationDate = Date.now
    @State private var notificationText = ""
    let localNotificationManager: LocalNotificationManager
    
    var body: some View {
        VStack {
            DatePicker("", selection: $notificationDate, in: Date.now...)
                .labelsHidden()
            TextField("Notification text", text: $notificationText)
                .textFieldStyle(.roundedBorder)
            Button("Schedule notification") {
                scheduleNotification()
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: 190)
    }
    
    func scheduleNotification() {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        let model = LocalNotificationModel(identifier: UUID().uuidString,
                                           title: "Schedule notification",
                                           subtitile: "",
                                           body: notificationText,
                                           dateComponents: components,
                                           repeats: false)
        localNotificationManager.scheduleNotification(model: model)
    }
}

#Preview {
    ScheduleNotification(localNotificationManager: LocalNotificationManager())
}
