//
//  Endpoint.swift
//  HEAITH
//
//  Created by 안세훈 on 5/5/25.
//

//MARK: - 2) Endpoint: bodyParameter, method, encoder 등 설정 값
import Foundation

// MARK: - HTTP 메서드 정의(쿼리)
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol BodyEncoder {
    func encode(_ parameters : [String : Any]) -> Data?
}

struct BodyEncoderImpl : BodyEncoder {
    func encode(_ parameters: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: parameters)
    }
}

protocol Requestable {
    var path: String { get }
//    var isFullPath: Bool { get }
    var method: HTTPMethod { get }
//    var headerParameters: [String: String] { get }
    var queryParametersEncodable: Encodable? { get }
    var queryParameters: [String: Any] { get }
    var bodyParametersEncodable: Encodable? { get }
    var bodyParameters: [String: Any] { get }
    var bodyEncoder: BodyEncoder { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

//request만드는데 나오는 에러.
enum RequestGenerationError: Error {
    case components
}


protocol ResponseRequestable : Requestable{
    associatedtype Response
    var responseDecoder: ResponseDecoder { get }
}

extension Requestable{
    func url(with config: NetworkConfigurable) throws -> URL{
        let baseURL = config.baseURL
        return
    }
}

class Endpoint<R> : ResponseRequestable {
    
    typealias Response = R
    
}
