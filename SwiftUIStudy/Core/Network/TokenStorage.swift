//
//  TokenStorage.swift
//  SwiftUIStudy
//
//  Created by USER on 24.11.2023.
//

import Foundation
import KeychainSwift

protocol TokenStorageProtocol {
    func set(token: String, key: TokenKeys)
    func get(tokenBy key: TokenKeys) -> String?
}

enum TokenKeys: String {
    case weather = "token_weather"
}

final class TokenStorage: TokenStorageProtocol {
    private let keychain = KeychainSwift()
    
    func set(token: String, key: TokenKeys) {
        self.keychain.set(token, forKey: key.rawValue)
    }
    
    func get(tokenBy key: TokenKeys) -> String? {
        self.keychain.get(key.rawValue)
    }
}
