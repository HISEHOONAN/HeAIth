//
//  NetworkSessionManager.swift
//  HEAITH
//
//  Created by 안세훈 on 5/5/25.
//

import Foundation

//MARK: - NetworkSessionManager: URLSession으로 URLSessionDataTask를 만든 후 resume()하는 부분

public protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable
}

public class NetworkSessionManagerImpl: NetworkSessionManager {
    
    public init() {}
    
    public func request(_ request: URLRequest,
                        completion: @escaping CompletionHandler) -> NetworkCancellable {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
