//
//  TestLiveActivity.swift
//  Test
//
//  Created by USER on 08.12.2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TestAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TestLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TestAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TestAttributes {
    fileprivate static var preview: TestAttributes {
        TestAttributes(name: "World")
    }
}

extension TestAttributes.ContentState {
    fileprivate static var smiley: TestAttributes.ContentState {
        TestAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TestAttributes.ContentState {
         TestAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TestAttributes.preview) {
   TestLiveActivity()
} contentStates: {
    TestAttributes.ContentState.smiley
    TestAttributes.ContentState.starEyes
}
