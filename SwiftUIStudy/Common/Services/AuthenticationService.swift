//
//  AuthenticationService.swift
//  SwiftUIStudy
//
//  Created by USER on 27.12.2023.
//

import Foundation

class AuthenticationService: ObservableObject {
    enum Status {
        case authenticated
        case unauthenticated
    }
    
    static var shared: AuthenticationService = AuthenticationService()
    
    @Published var status: Status {
        didSet {
            switch status {
            case .unauthenticated:
                UserDefaults.standard.removeObject(forKey: "timeAuth")
            case .authenticated:
                UserDefaults.standard.setValue(Date.now, forKey: "timeAuth")
            }
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: "user") {
            self.status = Status.authenticated
        } else {
            self.status = Status.unauthenticated
        }
    }
}
