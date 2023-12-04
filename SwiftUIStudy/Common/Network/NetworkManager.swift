//
//  NetworkManager.swift
//  SwiftUIStudy
//
//  Created by USER on 24.11.2023.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func request<T>(url: String,
                    method: HTTPMethod,
                    parameters: [String: Any],
                    headers: [String: String],
                    resultType: T.Type,
                    result: @escaping (Result<T?, Error>) -> Void) where T: Codable
}

final class NetworkManager: NetworkManagerProtocol {
    private let session: Session
    
    public static var shared: NetworkManagerProtocol = NetworkManager()
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        self.session = Session(configuration: configuration)
    }
    
    func request<T>(url: String,
                    method: HTTPMethod,
                    parameters: [String: Any],
                    headers: [String: String],
                    resultType: T.Type,
                    result: @escaping (Result<T?, Error>) -> Void) where T: Codable {
        self.session
            .request(url,
                     method: method,
                     parameters: parameters,
                     headers: headers.toHeader())
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    result(.success(data))
                case .failure(let error):
                    result(.failure(error))
                }
            }
    }
}

extension Dictionary where Key == String, Value == String {
    func toHeader() -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        for (key, value) in self  {
            headers.add(name: key, value: value)
        }
        return headers
    }
}
