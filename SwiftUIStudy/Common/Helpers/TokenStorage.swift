//
//  TokenStorage.swift
//  SwiftUIStudy
//
//  Created by USER on 30.11.2023.
//

import Foundation
import KeychainSwift

protocol TokenStorage {
    func set(token: String, key: TokenKeys)
    func get(tokenBy key: TokenKeys) -> String?
}

enum TokenKeys: String {
    case tokenWeather = "token_weather"
}

final class TokenStorageImpl: TokenStorage {
    
    private let keychain = KeychainSwift()
    
    func set(token: String, key: TokenKeys) {
        self.keychain.set(token, forKey: key.rawValue)
    }
    
    func get(tokenBy key: TokenKeys) -> String? {
        self.keychain.get(key.rawValue)
    }
    
}
