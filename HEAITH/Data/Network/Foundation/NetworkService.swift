//
//  NetworkService.swift
//  HEAITH
//
//  Created by 안세훈 on 5/5/25.
//

import Foundation

//MARK: - NetworkService : request, logger 사용

public protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable?
}


//MARK: - 실질적인 구현임.
public final class NetworkServiceImpl : NetworkService{
    public func request(endpoint: any Requestable, completion: @escaping CompletionHandler) -> (any NetworkCancellable)? {
        <#code#>
    }
    
    //이 세게를 이용해 request
    private let config : NetworkConfigurable
    private let sessionManager : NetworkSessionManager
    private let logger : NetworkErrorLogger
    
    init(
        config: NetworkConfigurable,
        sessionManager: NetworkSessionManager = NetworkSessionManagerImpl(),
        logger: NetworkErrorLogger = NetworkErrorLoggerImpl()
    ) {
        self.config = config
        self.sessionManager = sessionManager
        self.logger = logger
    }
    
    private func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
        
    }
}

//
//public final class DefaultNetworkService {
//
//    private let config: NetworkConfigurable
//    private let sessionManager: NetworkSessionManager
//    private let logger: NetworkErrorLogger
//
//    public init(config: NetworkConfigurable,
//                sessionManager: NetworkSessionManager = DefaultNetworkSessionManager(),
//                logger: NetworkErrorLogger = NetworkErrorLoggerImpl()) {
//        self.sessionManager = sessionManager
//        self.config = config
//        self.logger = logger
//    }
//
//    private func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
//
//        let sessionDataTask = sessionManager.request(request) { data, response, requestError in
//
//            if let requestError = requestError {
//                var error: NetworkError
//                if let response = response as? HTTPURLResponse {
//                    error = .error(statusCode: response.statusCode, data: data)
//                } else {
//                    error = self.resolve(error: requestError)
//                }
//
//                self.logger.log(error: error)
//                completion(.failure(error))
//            } else {
//                self.logger.log(responseData: data, response: response)
//                completion(.success(data))
//            }
//        }
//
//        logger.log(request: request)
//
//        return sessionDataTask
//    }
//
//    private func resolve(error: Error) -> NetworkError {
//        let code = URLError.Code(rawValue: (error as NSError).code)
//        switch code {
//        case .notConnectedToInternet: return .notConnected
//        case .cancelled: return .cancelled
//        default: return .generic(error)
//        }
//    }
//}
//
//extension DefaultNetworkService: NetworkService {
//
//    public func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable? {
//        do {
//            let urlRequest = try endpoint.urlRequest(with: config)
//            return request(request: urlRequest, completion: completion)
//        } catch {
//            completion(.failure(.urlGeneration))
//            return nil
//        }
//    }
//}

//MARK: - 네트워크 취소

public protocol NetworkCancellable{
    func cancel()
}

// 이미 cancel을 제공하므로, Networkcancellable로 확장해서 사용.
extension URLSessionTask: NetworkCancellable { }
