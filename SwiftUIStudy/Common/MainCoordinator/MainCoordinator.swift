//
//  MainCoordinator.swift
//  SwiftUIStudy
//
//  Created by USER on 30.11.2023.
//

import Foundation
import SwiftUI
import Stinsen

final class MainCoordinator: NavigationCoordinatable {
    private let localNotificationManager = LocalNotificationManager()
    private let getStreamManager = GetStreamManager()
    private let languageManager = LanguageManager()
    
    var stack: Stinsen.NavigationStack<MainCoordinator>
    
    @Root var content = makeContent
    @Root var auth = makeAuth
    
    @ViewBuilder func sharedView(_ view: AnyView) -> some View {
        view
            .onReceive(AuthenticationService.shared.$status) { status in
                switch status {
                case .authenticated(_):
                    self.root(\.content)
                case .unauthenticated:
                    self.root(\.auth)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                AppStateManager.shared.isActive = true
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                AppStateManager.shared.isActive = false
            }
    }
    
    @ViewBuilder func customize(_ view: AnyView) -> some View {
        sharedView(view)
    }
    
    init() {
        languageManager.setDefaultLanguage()
        switch AuthenticationService.shared.status {
        case .authenticated(_):
            stack = NavigationStack(initial: \MainCoordinator.content)
        case .unauthenticated:
            stack = NavigationStack(initial: \MainCoordinator.auth)
        }
    }
    
    func makeContent() -> ContentCoordinator {
        return ContentCoordinator(localNotificationManager: localNotificationManager,
                                                            getStreamManager: getStreamManager,
                                                            languageManager: languageManager)
    }
    
    func makeAuth() -> NavigationViewCoordinator<AuthCoordinator> {
        return NavigationViewCoordinator(AuthCoordinator(localNotificationManager: localNotificationManager,
                                                         getStreamManager: getStreamManager,
                                                         languageManager: languageManager))
    }
}
