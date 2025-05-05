//
//  NetworkConfig.swift
//  HEAITH
//
//  Created by 안세훈 on 5/5/25.
//

import Foundation

//네트워크 호출을 할때 기본적인 설정 값 (baseURL, headers, query parameters)을 설정
//cf) bodyParameter는 Endpoint에서 구현
//MARK: - 프로토콜에서 사용할 변수 정의

public protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: Any] { get }
}

//MARK: - 프로토콜 채택 후

public struct ApiDataNetworkConfig : NetworkConfigurable {
    public var baseURL: URL
    public var headers: [String : String]
    public var queryParameters: [String : Any]
    
    public init(baseURL: URL, headers: [String : String], queryParameters: [String : Any]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
