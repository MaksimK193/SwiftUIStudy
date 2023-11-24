//
//  NetworkManager.swift
//  SwiftUIStudy
//
//  Created by USER on 24.11.2023.
//

import Foundation
import Alamofire

typealias NetworkManagerUnionProtocol = NetworkManagerProtocol & NetworkManagerConfigurationProtocol

protocol NetworkManagerConfigurationProtocol {
    func set(tokenStorage: TokenStorage)
    func set(apiBaseURL: String)
    func set(clientID: String)
}

protocol NetworkManagerProtocol {
    func request<T>(_ route: NetworkGatewayProtocol,
                    resultType: T.Type,
                    result:@escaping (Result<T?, Error>) -> Void) where T: Codable
}

final class NetworkManager: NetworkManagerProtocol {
    private let session: Session
    private let decoder: DataDecoder
    private let dataPreprocessor: DataPreprocessor
    private var tokenStorage: TokenStorage? = TokenStorage()
    private var apiBaseURL: String? = "https://api.weather.yandex.ru/"
    private var clientID: String?
    
    public static var shared: NetworkManagerUnionProtocol = NetworkManager()
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        self.session = Session(configuration: configuration)
        self.decoder = JSONDecoder()
        self.dataPreprocessor = .passthrough
    }
    
    func request<T>(_ gateway: NetworkGatewayProtocol,
                    resultType: T.Type,
                    result: @escaping (Result<T?, Error>) -> Void) where T : Codable {
        self.request(gateway, queue: .main, resultType: resultType, result: result)
    }
    
    public func request<T>(_ gateway: NetworkGatewayProtocol,
                           queue: DispatchQueue = .main,
                           emptyResponseCodes: Set<Int> = [204, 205],
                           emptyRequestMethods: Set<GatewayMethod> = [.head],
                           successResponseCodes: Set<HTTPCode> = [.success,
                                                                  .accepted,
                                                                  .created,
                                                                  .nonAuthoritativeInformation,
                                                                  .noContent,
                                                                  .resetContent,
                                                                  .partialContent,
                                                                  .multiStatus,
                                                                  .alreadyReported,
                                                                  .imUsed],
                           resultType: T.Type,
                           result: @escaping (Result<T?, Error>) -> Void) where T: Codable {
        guard let baseURL = self.apiBaseURL,
              let token = self.tokenStorage?.get(tokenBy: .weather)
        else { return }
        self.session
            .request(NetworkGatewayAdapter(gateway: gateway,
                                           baseURL: baseURL,
                                           token: token))
            .validate(contentType: ["application/json"])
            .responseDecodable(of: T.self,
                               queue: queue,
                               dataPreprocessor: self.dataPreprocessor,
                               decoder: self.decoder,
                               emptyResponseCodes: emptyResponseCodes,
                               emptyRequestMethods: emptyRequestMethods) {response in
                if let statusCode = response.response?.statusCode,
                   let httpCode = HTTPCode(rawValue: statusCode),
                   successResponseCodes.contains(httpCode) {
                    switch response.result {
                    case .success(let data):
                        result(.success(data))
                    case .failure(let error):
                        result(.failure(error))
                    }
                } else {
                    let error = URLError(.badServerResponse)
                    result(.failure(error))
                }
            }
    }
}

extension NetworkManager: NetworkManagerConfigurationProtocol {
    func set(tokenStorage: TokenStorage) {
        self.tokenStorage = tokenStorage
    }
    
    func set(apiBaseURL: String) {
        self.apiBaseURL = apiBaseURL
    }
    
    func set(clientID: String) {
        self.clientID = clientID
    }
    
    
}
