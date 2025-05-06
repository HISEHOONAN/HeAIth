//
//  NetworkError.swift
//  HEAITH
//
//  Created by 안세훈 on 5/6/25.
//

import Foundation

//MARK: - 네트워크 에러 타입.
public enum NetworkError : Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

extension NetworkError {
    public var isNotFoundError: Bool { return hasStatusCode(404) }
    
    public func hasStatusCode(_ codeError: Int) -> Bool {
        switch self {
        case let .error(code, _):
            return code == codeError
        default: return false
        }
    }
}
