//
//  LiveActivityView.swift
//  SwiftUIStudy
//
//  Created by USER on 08.12.2023.
//

import SwiftUI
import ActivityKit

struct LiveActivityView: View {
    var body: some View {
        Text("Live Activity")
        Button("Start activity") {
            if ActivityAuthorizationInfo().areActivitiesEnabled {
                do {
                    let attributes = TestAttributes(name: "World")
                    let initialState = TestAttributes.ContentState(emoji: "😀")
                    let activity = try Activity.request(
                        attributes: attributes,
                        content: .init(state: initialState, staleDate: nil)
                    )
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    LiveActivityView()
}
