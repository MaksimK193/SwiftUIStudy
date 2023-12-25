//
//  SideBar.swift
//  SwiftUIStudy
//
//  Created by USER on 15.11.2023.
//

import SwiftUI
import Stinsen

struct SidebarView: View {
    @StateObject private var vm = SidebarViewModel()
    @ObservedObject var stateManager: AppStateManager
    @EnvironmentObject private var sidebarRouter: ContentCoordinator.Router
    @Binding var isSidebarOpened: Bool
    var sidebarWidth = UIScreen.main.bounds.size.width * 0.8
    
    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        isSidebarOpened.toggle()
                    }
                }
            }
        
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.2))
            .opacity(isSidebarOpened ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: isSidebarOpened)
            .onTapGesture {
                isSidebarOpened.toggle()
            }
            content
                .gesture(drag)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        HStack {
            List() {
                ForEach(vm.screens) { item in
                    Button(item.screen.screenTitle()) {
                        switch item.screen {
                        case .coreData:
                            sidebarRouter.route(to: \.coreData, stateManager)
                        case .swiftData:
                            sidebarRouter.route(to: \.swiftData, stateManager)
                        case .weather:
                            sidebarRouter.route(to: \.weather, stateManager)
                        case .photoCompression:
                            sidebarRouter.route(to: \.photoCompression, stateManager)
                        case .liveActivity:
                            sidebarRouter.route(to: \.liveActivity)
                        case .scheduleNotification:
                            sidebarRouter.route(to: \.scheduleNotification)
                        case .getStreamChat:
                            sidebarRouter.route(to: \.getStreamChat)
                        case .geoTrack:
                            sidebarRouter.route(to: \.geoTrack)
                        case .changeLanguage:
                            sidebarRouter.route(to: \.changeLanguage)
                        case .carousel:
                            sidebarRouter.route(to: \.carousel)
                        }
                    }
                    .accessibilityIdentifier("\(item.screen.rawValue)")
                }
            }
            .listStyle(.plain)
            .padding([.top], 60)
            .background()
            .frame(width: sidebarWidth)
            .offset(x: isSidebarOpened ? 0 : -sidebarWidth)
            .animation(.default, value: isSidebarOpened)
            Spacer()
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(stateManager: AppStateManager.shared)
    }
}
