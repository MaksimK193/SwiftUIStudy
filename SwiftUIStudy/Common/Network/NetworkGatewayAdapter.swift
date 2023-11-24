//
//  NetworkGatewayAdapter.swift
//  SwiftUIStudy
//
//  Created by USER on 24.11.2023.
//

import Foundation
import Alamofire

struct NetworkGatewayAdapter: URLRequestConvertible {
    private let gateway: NetworkGatewayProtocol
    private let baseURL: String
    private let token: String?
    
    init(gateway: NetworkGatewayProtocol,
         baseURL: String,
         token: String?) {
        self.gateway = gateway
        self.baseURL = baseURL
        self.token = token
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try (self.baseURL + self.gateway.path).asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = gateway.method.rawValue
        urlRequest.allHTTPHeaderFields = gateway.headers?.dictionary
        if let token = self.token {
            urlRequest.allHTTPHeaderFields?["X-Yandex-API-Key"] = "\(token)"
        }
        switch gateway.method {
        case .get:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: gateway.parameters)
        default:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: gateway.parameters)
        }
        return urlRequest
    }
}
