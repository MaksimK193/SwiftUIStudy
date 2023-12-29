//
//  AuthCoordinator.swift
//  SwiftUIStudy
//
//  Created by USER on 27.12.2023.
//

import Foundation
import Stinsen
import SwiftUI

final class AuthCoordinator: NavigationCoordinatable {
    let localNotificationManager: LocalNotificationManager
    let getStreamManager: GetStreamManager
    let languageManager: LanguageManager
    let stack = NavigationStack(initial: \AuthCoordinator.start)
    
    @Root var start = makeStart
    @Route(.push) var content = makeContent
    
    init(localNotificationManager: LocalNotificationManager,
         getStreamManager: GetStreamManager,
         languageManager: LanguageManager) {
        self.localNotificationManager = localNotificationManager
        self.getStreamManager = getStreamManager
        self.languageManager = languageManager
    }
    
    @ViewBuilder func makeStart() -> some View {
        AuthView()
    }
    
    func makeContent() -> NavigationViewCoordinator<ContentCoordinator> {
        return NavigationViewCoordinator(ContentCoordinator(localNotificationManager: localNotificationManager,
                                                            getStreamManager: getStreamManager,
                                                            languageManager: languageManager))
    }
}
