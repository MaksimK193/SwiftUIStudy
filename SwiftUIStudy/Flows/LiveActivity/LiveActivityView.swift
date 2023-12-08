//
//  LiveActivityView.swift
//  SwiftUIStudy
//
//  Created by USER on 08.12.2023.
//

import SwiftUI
import ActivityKit

struct LiveActivityView: View {
    @State private var activity: Activity<TestAttributes>? = nil
    @State private var isButtonsShown = false
    
    var body: some View {
        Text("Live Activity")
        
        Button("Start activity") {
            if ActivityAuthorizationInfo().areActivitiesEnabled {
                do {
                    let attributes = TestAttributes()
                    let initialState = TestAttributes.ContentState(status: "Приняли")
                    activity = try Activity.request(
                        attributes: attributes,
                        content: .init(state: initialState, staleDate: nil)
                    )
                    withAnimation {
                        isButtonsShown.toggle()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .buttonStyle(.bordered)
        
        Button("Готовим") {
            guard let activity = activity else { return }
            let contentState = TestAttributes.ContentState(status: "Готовим")
            Task {
                await activity.update(ActivityContent(state: contentState, staleDate: Date.now + 15))
            }
        }
        .buttonStyle(.bordered)
        .opacity(isButtonsShown ? 1 : 0)
        
        Button("Доставляем") {
            guard let activity = activity else { return }
            let contentState = TestAttributes.ContentState(status: "Доставляем")
            Task {
                await activity.update(ActivityContent(state: contentState, staleDate: Date.now + 15))
            }
        }
        .buttonStyle(.bordered)
        .opacity(isButtonsShown ? 1 : 0)
        
        Button("Завершен") {
            guard let activity = activity else { return }
            let contentState = TestAttributes.ContentState(status: "Завершен")
            
            Task {
                await activity.end(ActivityContent(state: contentState, staleDate: nil), dismissalPolicy: .after(.now + 5))
            }
        }
        .buttonStyle(.bordered)
        .opacity(isButtonsShown ? 1 : 0)
    }
}

#Preview {
    LiveActivityView()
}
