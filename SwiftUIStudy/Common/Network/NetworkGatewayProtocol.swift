//
//  NetworkGatewayProtocol.swift
//  SwiftUIStudy
//
//  Created by USER on 24.11.2023.
//

import Foundation
import Alamofire

public typealias GatewayMethod = HTTPMethod
public typealias GatewayHeaders = HTTPHeaders

protocol NetworkGatewayProtocol {
    /// используемые заголовки
    var headers: GatewayHeaders? { get }
    /// метод запроса
    var method: GatewayMethod { get }
    /// путь
    var path: String { get }
    /// передаваемые параметры
    var parameters: [String: Any]? { get }
}

public extension GatewayHeaders {
    static var defaultJSON: Self {
        return [
            "Content-Type": "application/json",
        ]
    }
}
