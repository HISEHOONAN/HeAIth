//
//  NetworkConfig.swift
//  HEAITH
//
//  Created by 안세훈 on 5/5/25.
//

//MARK: - 1) NetworkConfig: URL request 시 기본 설정 값

import Foundation

public protocol NetworkConfigurable {
    var baseURL: URL { get }
//    var headers: [String: String] { get } 헤더입니다.
    var queryParameters: [String: Any] { get }
}


public struct ApiDataNetworkConfig : NetworkConfigurable {
    public var baseURL: URL { URL(string: "https://kdt-api-function.azurewebsites.net")! }
    public var queryParameters: [String : Any] { [:] }
}

