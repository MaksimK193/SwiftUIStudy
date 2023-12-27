//
//  AuthenticationService.swift
//  SwiftUIStudy
//
//  Created by USER on 27.12.2023.
//

import Foundation

struct User: Codable, Equatable {
    let username: String
    let accessToken: String
}

class AuthenticationService: ObservableObject {
    enum Status: Equatable {
        case authenticated(User)
        case unauthenticated
    }
    
    static var shared: AuthenticationService = AuthenticationService()
    
    @Published var status: Status {
        didSet {
            switch status {
            case .unauthenticated:
                UserDefaults.standard.removeObject(forKey: "user")
            case .authenticated(let user):
                let encoder = JSONEncoder()
                let jsonString = try! encoder.encode(user)
                UserDefaults.standard.setValue(jsonString, forKey: "user")
            }
        }
    }

    init() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "user") {
            self.status = try! Status.authenticated(decoder.decode(User.self, from: data))
        } else {
            self.status = Status.unauthenticated
        }
    }
}
