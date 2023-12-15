//
//  GetStreamManager.swift
//  SwiftUIStudy
//
//  Created by USER on 15.12.2023.
//

import Foundation
import StreamChat
import StreamChatSwiftUI

class GetStreamManager {
    private let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidGVzdHVzZXIyIn0.M06OmbF751aWGMCYaEe9JnwQd5gD9hQuazG9K7jjVjk"
    private let apiKey = "7q4vavghsnjb"
    private let appGroupId = "fojin.SwiftUIStudy"
    var streamChat: StreamChat?
    var chatClient: ChatClient
    
    init() {
        var config = ChatClientConfig(apiKey: .init(apiKey))
        config.isLocalStorageEnabled = true
        config.applicationGroupIdentifier = appGroupId
        chatClient = ChatClient(config: config)
        streamChat = StreamChat(chatClient: chatClient)
        connectUser()
    }
    
    private func connectUser() {
        let token = try! Token(rawValue: token)
        chatClient.connectUser(userInfo: .init(id: "testuser2"),
                               token: token) { error in
            if let error = error {
                print("Connecting the user failed \(error)")
            }
        }
    }
    
    func createChannel(channelId: String) {
        let channelId = ChannelId(type: .messaging, id: channelId)
        
        let channelController = chatClient.channelController(for: channelId)
        channelController.addMembers(userIds: ["testuser2"])
        channelController.synchronize()
    }
}
