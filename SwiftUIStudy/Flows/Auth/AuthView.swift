//
//  AuthView.swift
//  SwiftUIStudy
//
//  Created by USER on 27.12.2023.
//

import LocalAuthentication
import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var authRouter: AuthCoordinator.Router
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertTitleText = ""
    private let correctLogin = "123"
    private let correctPassword = "123"
    
    var body: some View {
        VStack {
            TextField("Login", text: $login)
                .textFieldStyle(.roundedBorder)
            TextField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            HStack {
                Button("Войти") {
                    if login == correctLogin && password == correctPassword {
                        loginInApp()
                    } else {
                        alertTitleText = "Incorrect login or password"
                        showAlert = true
                    }
                }
                .buttonStyle(.bordered)
                Button("Face ID") {
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
            alertTitleText = "Incorrect Face ID"
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
