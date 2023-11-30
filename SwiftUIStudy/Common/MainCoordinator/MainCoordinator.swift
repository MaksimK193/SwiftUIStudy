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
    
    init() {
        stack = NavigationStack(initial: \MainCoordinator.content)
    }
    
    func makeContent() -> NavigationViewCoordinator<ContentCoordinator> {
        return NavigationViewCoordinator(ContentCoordinator())
    }
}
