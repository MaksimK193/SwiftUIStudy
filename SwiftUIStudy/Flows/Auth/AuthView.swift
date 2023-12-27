//
//  AuthView.swift
//  SwiftUIStudy
//
//  Created by USER on 27.12.2023.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var authRouter: AuthCoordinator.Router
    var body: some View {
        Button("Войти") {
            DispatchQueue.main.async {
                AuthenticationService.shared.status = .authenticated(
                    User(
                        username: "username",
                        accessToken: UUID().uuidString
                    )
                )
            }
        }
    }
}

#Preview {
    AuthView()
}
