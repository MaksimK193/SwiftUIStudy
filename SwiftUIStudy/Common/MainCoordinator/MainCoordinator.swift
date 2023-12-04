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
    var stack: Stinsen.NavigationStack<MainCoordinator>
    
    @Root var content = makeContent
    
    @ViewBuilder func sharedView(_ view: AnyView) -> some View {
        view
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
        stack = NavigationStack(initial: \MainCoordinator.content)
    }
    
    func makeContent() -> NavigationViewCoordinator<ContentCoordinator> {
        return NavigationViewCoordinator(ContentCoordinator())
    }
}
