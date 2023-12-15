//
//  GetStreamChatView.swift
//  SwiftUIStudy
//
//  Created by USER on 14.12.2023.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct GetStreamChatView: View {
    let getStreamManager: GetStreamManager?
    @StateObject private var viewModel: ChatChannelListViewModel
    
    public init(channelListController: ChatChannelListController? = nil,
                getStreamManager: GetStreamManager) {
        let channelListVM = ViewModelsFactory.makeChannelListViewModel(channelListController: channelListController,
                                                                       selectedChannelId: nil)
        _viewModel = StateObject(wrappedValue: channelListVM)
        self.getStreamManager = getStreamManager
    }
    
    var body: some View {
        ChannelList(factory: DefaultViewFactory.shared,
                    channels: viewModel.channels,
                    selectedChannel: $viewModel.selectedChannel,
                    swipedChannelId: $viewModel.swipedChannelId,
                    onItemTap: { channel in
                        viewModel.selectedChannel = channel.channelSelectionInfo
                    },
                    onItemAppear: { index in
                        viewModel.checkForChannels(index: index)
                    },
                    channelDestination: DefaultViewFactory.shared.makeChannelDestination())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: { newChatButton })
        }
    }
    
    @ViewBuilder var newChatButton: some View {
        Button("", systemImage: "pencil.circle.fill") {
            getStreamManager?.createChannel(channelId: "id")
        }
        .accessibilityIdentifier("newChatButton")
    }
}

#Preview {
    GetStreamChatView(getStreamManager: GetStreamManager())
}
