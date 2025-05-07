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
    var method: HTTPMethod { get }
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
    
    func url(with config: NetworkConfigurable) throws -> URL {
        let baseURLString = config.baseURL.absoluteString.hasSuffix("/") ? config.baseURL.absoluteString : config.baseURL.absoluteString + "/"
        let endpoint = baseURLString + path
        
        guard var urlComponents = URLComponents(string: endpoint) else {
            throw RequestGenerationError.components
        }
        
        var allQueryItems = [URLQueryItem]()
        
        let combinedQueryParameters = (try? queryParametersEncodable?.toDictionary()) ?? queryParameters
        
        // ✅ client_id 자동 추가
        
        combinedQueryParameters.forEach {
            allQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        
        config.queryParameters.forEach {
            allQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        
        if !allQueryItems.isEmpty {
            urlComponents.queryItems = allQueryItems
        }
        
        guard let url = urlComponents.url else {
            throw RequestGenerationError.components
        }
        
        return url
    }
    
    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try self.url(with: config)
        var request = URLRequest(url: url)
        
        // 헤더가 있을때만 넣어주세용.
        //        var allHeaders = config.headers
        
        //        request.allHTTPHeaderFields = allHeaders
        request.httpMethod = method.rawValue
        
        let combinedBodyParameters = (try? bodyParametersEncodable?.toDictionary()) ?? bodyParameters
        if !combinedBodyParameters.isEmpty {
            request.httpBody = bodyEncoder.encode(combinedBodyParameters)
        }
        
        return request
    }
}

// MARK: - Endpoint 클래스
class Endpoint<R>: ResponseRequestable {
    typealias Response = R
    
    let path: String
    let method: HTTPMethod
    let queryParametersEncodable: Encodable?
    let queryParameters: [String: Any]
    let bodyParametersEncodable: Encodable?
    let bodyParameters: [String: Any]
    let bodyEncoder: BodyEncoder
    let responseDecoder: ResponseDecoder
    
    init(
        path: String,
        method: HTTPMethod,
        queryParametersEncodable: Encodable? = nil,
        queryParameters: [String: Any] = [:],
        bodyParametersEncodable: Encodable? = nil,
        bodyParameters: [String: Any] = [:],
        bodyEncoder: BodyEncoder = BodyEncoderImpl(),
        responseDecoder: ResponseDecoder = JSONResponseDecoder()
    ) {
        self.path = path
        self.method = method
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.bodyParametersEncodable = bodyParametersEncodable
        self.bodyParameters = bodyParameters
        self.bodyEncoder = bodyEncoder
        self.responseDecoder = responseDecoder
    }
}

// MARK: - Encodable 확장: toDictionary
private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return json as? [String: Any]
    }
}


struct AlanChatEndpoint: ResponseRequestable {
    typealias Response = AlanResponseDTO
    
    let path: String = "question"
    let method: HTTPMethod = .get
    
    var queryParametersEncodable: Encodable? = nil
    var queryParameters: [String: Any]
    var bodyParametersEncodable: Encodable? = nil
    var bodyParameters: [String: Any] = [:]
    var bodyEncoder: BodyEncoder = BodyEncoderImpl()
    var responseDecoder: ResponseDecoder = JSONResponseDecoder()
    
    init(content: String) {
        self.queryParameters = ["content": content]
    }
}
