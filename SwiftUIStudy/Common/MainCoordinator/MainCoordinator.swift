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
    
    private var routeAfterDeepLink: (Bool, TaskScreens?) = (false, nil)
    
    @Root var content = makeContent
    @Root var auth = makeAuth
    
    @ViewBuilder func sharedView(_ view: AnyView) -> some View {
        view
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                AppStateManager.shared.isActive = true
                guard let date  = UserDefaults.standard.object(forKey: "timeAuth") as? Date else { return }
                if date.timeIntervalSinceNow < -30 {
                    AuthenticationService.shared.status = .unauthenticated
                } else {
                    UserDefaults.standard.set(Date.now, forKey: "timeAuth")
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                AppStateManager.shared.isActive = false
                UserDefaults.standard.set(Date.now, forKey: "timeAuth")
            }
            .onReceive(AuthenticationService.shared.$status) { status in
                switch status {
                case .authenticated:
                    self.root(\.content)
                    
                    if self.routeAfterDeepLink.0 {
                        guard let screen = self.routeAfterDeepLink.1 else { return }
                        self.route(to: screen)
                        self.routeAfterDeepLink = (false, nil)
                    }
                case .unauthenticated:
                    self.root(\.auth)
                }
            }
            .onOpenURL { url in
                guard let screen = self.handleIncomingURL(url) else {
                    print("Invalid deeplink")
                    return
                }
                
                if let coordinator = self.hasRoot(\.auth) {
                    self.routeAfterDeepLink = (true, screen)
                }
                
                self.route(to: screen)
            }
    }
    
    @ViewBuilder func customize(_ view: AnyView) -> some View {
        sharedView(view)
    }
    
    init() {
        languageManager.setDefaultLanguage()
        switch AuthenticationService.shared.status {
        case .authenticated:
            stack = NavigationStack(initial: \MainCoordinator.content)
        case .unauthenticated:
            stack = NavigationStack(initial: \MainCoordinator.auth)
        }
    }
    
    func route(to screen: TaskScreens) {
        guard let coordinator = self.hasRoot(\.content) else { return }
        switch screen {
        case .coreData:
            coordinator.child.route(to: \.coreData, AppStateManager())
        case .swiftData:
            coordinator.child.route(to: \.swiftData, AppStateManager())
        case .weather:
            coordinator.child.route(to: \.weather, AppStateManager())
        case .photoCompression:
            coordinator.child.route(to: \.photoCompression, AppStateManager())
        case .liveActivity:
            coordinator.child.route(to: \.liveActivity)
        case .scheduleNotification:
            coordinator.child.route(to: \.scheduleNotification)
        case .getStreamChat:
            coordinator.child.route(to: \.getStreamChat)
        case .geoTrack:
            coordinator.child.route(to: \.geoTrack)
        case .changeLanguage:
            coordinator.child.route(to: \.changeLanguage)
        case .carousel:
            coordinator.child.route(to: \.carousel)
        case .notificationActions:
            coordinator.child.route(to: \.notificationActions)
        case .avatar:
            coordinator.child.route(to: \.avatar)
        case .countries:
            coordinator.child.route(to: \.countries)
        case .yandexMaps:
            coordinator.child.route(to: \.yandexMaps)
        case .realm:
            coordinator.child.route(to: \.realm)
        case .exit:
            break
        }
    }
    
    func makeContent() -> NavigationViewCoordinator<ContentCoordinator> {
        return NavigationViewCoordinator(ContentCoordinator(localNotificationManager: localNotificationManager,
                                                            getStreamManager: getStreamManager,
                                                            languageManager: languageManager))
    }
    
    func makeAuth() -> NavigationViewCoordinator<AuthCoordinator> {
        return NavigationViewCoordinator(AuthCoordinator(localNotificationManager: localNotificationManager,
                                                         getStreamManager: getStreamManager,
                                                         languageManager: languageManager))
    }
}

extension MainCoordinator {
    private func handleIncomingURL(_ url: URL) -> TaskScreens? {
        guard url.scheme == "swiftuistudy" else {
            return nil
        }
    
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Invalid URL")
            return nil
        }

        guard let action = components.host, action == "open-screen" else {
            print("Unknown URL, we can't handle this one!")
            return nil
        }

        guard let name = components.queryItems?.first(where: { $0.name == "name" })?.value else {
            print("Recipe name not found")
            return nil
        }
        
        guard let screen = TaskScreens(rawValue: name) else {
            print("Invalid screen name")
            return nil
        }
        
        return screen
    }
}
