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
        Text(L10n.LiveActivity.Label.liveActivity)
        
        Button(L10n.LiveActivity.Button.startActivity) {
            if ActivityAuthorizationInfo().areActivitiesEnabled {
                do {
                    let attributes = TestAttributes()
                    let initialState = TestAttributes.ContentState(status: L10n.LiveActivity.ActivityStatus.accepted)
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
        
        Button(L10n.LiveActivity.Button.cook) {
            guard let activity = activity else { return }
            let contentState = TestAttributes.ContentState(status: L10n.LiveActivity.ActivityStatus.cook)
            Task {
                await activity.update(ActivityContent(state: contentState, staleDate: Date.now + 15))
            }
        }
        .buttonStyle(.bordered)
        .opacity(isButtonsShown ? 1 : 0)
        
        Button(L10n.LiveActivity.Button.deliver) {
            guard let activity = activity else { return }
            let contentState = TestAttributes.ContentState(status: L10n.LiveActivity.ActivityStatus.deliver)
            Task {
                await activity.update(ActivityContent(state: contentState, staleDate: Date.now + 15))
            }
        }
        .buttonStyle(.bordered)
        .opacity(isButtonsShown ? 1 : 0)
        
        Button(L10n.LiveActivity.Button.finished) {
            guard let activity = activity else { return }
            let contentState = TestAttributes.ContentState(status: L10n.LiveActivity.ActivityStatus.finished)
            
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
