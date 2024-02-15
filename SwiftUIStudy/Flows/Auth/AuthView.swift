//
//  AuthView.swift
//  SwiftUIStudy
//
//  Created by USER on 27.12.2023.
//

import SwiftUI
import LocalAuthentication
import YandexMobileMetrica

struct AuthView: View {
    @EnvironmentObject private var authRouter: AuthCoordinator.Router
    @State private var login: String = "123"
    @State private var password: String = "123"
    @State private var showAlert: Bool = false
    @State private var alertTitleText = ""
    private let correctLogin = "123"
    private let correctPassword = "123"
    
    var body: some View {
        VStack {
            TextField(L10n.Auth.TextField.login, text: $login)
                .textFieldStyle(.roundedBorder)
            TextField(L10n.Auth.TextField.password, text: $password)
                .textFieldStyle(.roundedBorder)
            HStack {
                Button(L10n.Auth.Button.login) {
                    if login == correctLogin && password == correctPassword {
                        loginInApp()
                    } else {
                        alertTitleText = L10n.Auth.Alert.Title.incorrectPasswordOrLogin
                        showAlert = true
                    }
                }
                .buttonStyle(.bordered)
                Button(L10n.Auth.Button.faceID) {
                    authenticate()
                }
            }
            .padding()
        }
        .frame(maxWidth: 200)
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitleText))
        }
        .onAppear {
            YMMYandexMetrica.reportEvent("AuthScreen opened")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    loginInApp()
                }
            }
        } else {
            alertTitleText = L10n.Auth.Alert.Title.incorrectFaceID
            showAlert = true
        }
    }
    
    func loginInApp() {
        DispatchQueue.main.async {
            AuthenticationService.shared.status = .authenticated
        }
    }
}

#Preview {
    AuthView()
}
