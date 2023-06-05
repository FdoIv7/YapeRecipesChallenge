//
//  RequestProtocolTests.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 28/05/23.
//

import Foundation
import XCTest
@testable import YapeRecipesChallenge

class RequestProtocolTests: XCTestCase {
    
    var sut: RequestProtocol!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    struct MockRequest: RequestProtocol {
        let path: String = "/mock/path"
        let headers: [String : String] = ["Content-Type": "application/json"]
        let params: [String : Any] = ["param1": "value1", "param2": 2]
        let urlParams: [String : String?] = [:]
        let requestType: RequestType = .GET
    }
    
    func test_createURLRequest_success() {
        // Given
        sut = MockRequest()
        let exp = expectation(description: "Created URL Request Successfully")
        var requestResult: URLRequest!
        
        // When
        do {
            requestResult = try sut.createURLRequest()
            exp.fulfill()
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
        // Then
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(requestResult)
        XCTAssertEqual(requestResult.url?.scheme, "http")
        XCTAssertEqual(requestResult.url?.host, "demo4677561.mockable.io")
        XCTAssertEqual(requestResult.url?.path, "/mock/path")
        XCTAssertEqual(requestResult.httpMethod, "GET")
        XCTAssertEqual(requestResult.allHTTPHeaderFields?["Content-Type"], "application/json")
    }
    
    func test_createURLRequest_validURL() {
        // Given
        struct MockRequestForURL: RequestProtocol {
            var requestType: RequestType {
                .GET
            }
        }
        let sut = MockRequestForURL()
        var urlRequest: URLRequest!
        
        // When
        do {
            urlRequest = try sut.createURLRequest()
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://demo4677561.mockable.io/recipes_world")
    }
    
    func test_requestParams() {
        // Given
        sut = MockRequest()
        var requestResult: URLRequest!
        var requestBody: Data!
        var parameters: [String: Any]!
        
        // When
        do {
            requestResult = try sut.createURLRequest()
            requestBody = requestResult.httpBody
            parameters = try JSONSerialization.jsonObject(
                with: requestBody,
                options: []) as? [String: Any]
        } catch {
            XCTFail("Unexpceted error: \(error)")
        }
        
        // Then
        XCTAssertNotNil(requestResult)
        XCTAssertNotNil(requestBody)
        XCTAssertEqual(parameters?["param1"] as? String, "value1")
        XCTAssertEqual(parameters?["param2"] as? Int, 2)
    }

    func test_createURLRequest_failure() {
        // Given
        let exp = expectation(description: "Created invalid URL Request")
        sut = InvalidRequest()
        var errorResult: Error!

        // When
        XCTAssertThrowsError(try sut.createURLRequest()) { error in
            errorResult = error
            exp.fulfill()
        }
        // Then
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(errorResult)
        XCTAssertEqual(errorResult as? NetworkError, NetworkError.invalidURL)
    }

    struct InvalidRequest: RequestProtocol {
        let path: String = "Invalid path with spaces"
        let headers: [String : String] = ["Content-Type": "application/json"]
        let params: [String : Any] = [:]
        let urlParams: [String : String?] = [:]
        let requestType: RequestType = .POST

        func createURLRequest() throws -> URLRequest {
            var components = URLComponents()
            components.scheme = "http"
            components.host = "demo4677561.mockable.io"
            components.path = path

            if !urlParams.isEmpty {
                components.queryItems = urlParams.map({
                    URLQueryItem(name: $0, value: $1)
                })
            }

            guard let url = components.url else {
                throw NetworkError.invalidURL
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = requestType.rawValue

            if !headers.isEmpty {
                urlRequest.allHTTPHeaderFields = headers
            }

            if !params.isEmpty {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
            }
            return urlRequest
        }
    }
}
