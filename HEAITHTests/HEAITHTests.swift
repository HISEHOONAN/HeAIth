//
//  HEAITHTests.swift
//  HEAITHTests
//
//  Created by 안세훈 on 5/7/25.
//

import XCTest
@testable import HEAITH

final class DataTransferServiceTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}



//MARK: - test

final class EndpointTests: XCTestCase {
    
    func testMockEndpointURLRequest_containsClientID() throws {
        
        struct DummyResponse: Decodable {
            let id: Int
        }
        
        struct MockNetworkConfig: NetworkConfigurable {
            let baseURL: URL = URL(string: "https://kdt-api-function.azurewebsites.net/api/v1")!
            let headers: [String : String] = [:]
            let queryParameters: [String : Any] = [:]
        }
        
        func test_AlanChatEndpoint_generatesValidURLRequest() throws {
            let endpoint = AlanChatEndpoint(content: "안녕?")
            let config = MockNetworkConfig()
            
            let request = try endpoint.urlRequest(with: config)
            
            XCTAssertEqual(request.url?.scheme, "https")
            XCTAssertEqual(request.url?.host, "kdt-api-function.azurewebsites.net")
            XCTAssertEqual(request.url?.path, "/api/v1/question")
            
            let query = request.url?.query ?? ""
            XCTAssertTrue(query.contains("client_id="))
            XCTAssertTrue(query.contains("content=안녕%3F"))  // "안녕?" URL 인코딩됨
            XCTAssertEqual(request.httpMethod, "GET")
        }
    }
}
