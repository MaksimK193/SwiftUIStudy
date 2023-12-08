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
        var status: String
    }
}

struct TestLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TestAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text(context.state.status)
            }

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
                    Text("Bottom \(context.state.status)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.status)")
            } minimal: {
                Text(context.state.status)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
