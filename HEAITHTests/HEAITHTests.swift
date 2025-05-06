//
//  HEAITHTests.swift
//  HEAITHTests
//
//  Created by 안세훈 on 5/7/25.
//

import XCTest
@testable import HEAITH

final class DataTransferServiceTests: XCTestCase {

    private var sut: DefaultDataTransferService!
    private var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = DefaultDataTransferService(with: mockNetworkService)
    }

    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func test_request_successfulDecoding() {
        // Given
        let expectedModel = TestModel(id: 1, name: "Test")
        let data = try! JSONEncoder().encode(expectedModel)
        mockNetworkService.result = .success(data)
        
        let expectation = self.expectation(description: "Completion called")
        
        // When
        _ = sut.request(with: MockEndpoint<TestModel>()) { result in
            // Then
            switch result {
            case .success(let model):
                XCTAssertEqual(model.id, expectedModel.id)
                XCTAssertEqual(model.name, expectedModel.name)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func test_request_decodingError() {
        // Given
        let invalidData = Data("invalid json".utf8)
        mockNetworkService.result = .success(invalidData)
        
        let expectation = self.expectation(description: "Completion called")
        
        // When
        _ = sut.request(with: MockEndpoint<TestModel>()) { result in
            // Then
            if case .failure(let error) = result {
                if case .parsing = error {
                    XCTAssertTrue(true)
                } else {
                    XCTFail("Expected parsing error")
                }
            } else {
                XCTFail("Expected failure, got success")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}



struct TestModel: Codable, Equatable {
    let id: Int
    let name: String
}

class MockNetworkService: NetworkService {
    var result: Result<Data?, NetworkError>?
    
    func request(endpoint: any Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable? {
        if let result = result {
            completion(result)
        }
        return nil
    }
}

struct MockEndpoint<T: Decodable>: ResponseRequestable {
    typealias Response = T

    var path: String = "/mock"
    var method: HTTPMethod = .get
    var queryParametersEncodable: Encodable? = nil
    var queryParameters: [String: Any] = [:]
    var bodyParametersEncodable: Encodable? = nil
    var bodyParameters: [String: Any] = [:]
    var bodyEncoder: BodyEncoder = BodyEncoderImpl()
    var responseDecoder: ResponseDecoder = JSONResponseDecoder()
}

struct MockResponse: Decodable {
    let id: Int
    let name: String
}

struct MockNetworkConfig: NetworkConfigurable {
    var baseURL: URL {
        return URL(string: "https://mockapi.com")!
    }
    var headers: [String: String] = [:]
    var queryParameters: [String: Any] = [:]
}

func testMockEndpointURLRequest() throws {
    let endpoint = MockEndpoint<MockResponse>()
    let config = MockNetworkConfig()
    
    let request = try endpoint.urlRequest(with: config)
    XCTAssertEqual(request.url?.absoluteString, "https://mockapi.com/mock")
    XCTAssertEqual(request.httpMethod, "GET")
}

//MARK: - endpointtest

final class EndpointTests: XCTestCase {
    func testMockEndpointURLRequest() throws {
        struct MockResponse: Decodable {
            let id: Int
            let name: String
        }

        struct MockNetworkConfig: NetworkConfigurable {
            var baseURL: URL {
                return URL(string: "https://mockapi.com")!
            }
            var headers: [String: String] = [:]
            var queryParameters: [String: Any] = [:]
        }

        struct MockEndpoint<T: Decodable>: ResponseRequestable {
            typealias Response = T

            var path: String = "mock"
            var method: HTTPMethod = .get
            var queryParametersEncodable: Encodable? = nil
            var queryParameters: [String: Any] = [:]
            var bodyParametersEncodable: Encodable? = nil
            var bodyParameters: [String: Any] = [:]
            var bodyEncoder: BodyEncoder = BodyEncoderImpl()
            var responseDecoder: ResponseDecoder = JSONResponseDecoder()
        }

        let endpoint = MockEndpoint<MockResponse>()
        let config = MockNetworkConfig()
        
        let request = try endpoint.urlRequest(with: config)
        
        XCTAssertEqual(request.url?.absoluteString, "https://mockapi.com/mock")
        XCTAssertEqual(request.httpMethod, "GET")
    }
}
