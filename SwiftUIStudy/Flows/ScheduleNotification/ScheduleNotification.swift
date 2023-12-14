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
    private let center = UNUserNotificationCenter.current()
    
    var body: some View {
        VStack {
            DatePicker("", selection: $notificationDate, in: Date.now...)
                .labelsHidden()
            TextField("Notification text", text: $notificationText)
                .textFieldStyle(.roundedBorder)
            Button("Schedule notification") {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        let content = UNMutableNotificationContent()
                        content.title = "Schedule notification"
                        content.subtitle = notificationText
                        content.sound = UNNotificationSound.default
                        
                        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
                        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        center.add(request)
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: 190)
    }
}

#Preview {
    ScheduleNotification()
}
