//
//  APIManagerServiceTests.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 29/05/23.
//

import Foundation
import XCTest
@testable import YapeRecipesChallenge

class APIManagerServiceTests: XCTestCase {
    var sut: APIManagerServiceProtocol!

    override func setUp() {
        super.setUp()
        sut = createService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    private func createURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        return urlSession
    }

    private func createService() -> APIManagerServiceProtocol {
        return APIManagerService(urlSession: createURLSession())
    }

    
    func test_performRequest_sendingCorrectData() async throws {
        // Given
        let exp = expectation(description: "Perform Request")
        let mockRecipe = getMockRecipe()
        let mockRequest = getMockRequest()
        let mockData = try JSONEncoder().encode(mockRecipe)
        var requestResult: URLRequest!
        TestURLProtocol.lastRequest = nil
        TestURLProtocol.mockData = mockData
        TestURLProtocol.response = HTTPURLResponse(
            url: URL(string: "http://demo4677561.mockable.io/recipes_world")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        TestURLProtocol.stubResponse(statusCode: 200)
        TestURLProtocol.error = nil

        // When
        let data = try await sut.perform(mockRequest)
        exp.fulfill()
        requestResult = TestURLProtocol.lastRequest

        // Then
        XCTAssertNotNil(requestResult)
        XCTAssertEqual(data, mockData)
        XCTAssertEqual(requestResult.url?.absoluteString, "http://demo4677561.mockable.io/recipes_world")
        XCTAssertEqual(requestResult.httpMethod, RequestType.GET.rawValue)
        XCTAssertEqual(requestResult.allHTTPHeaderFields?["Content-Type"], "application/json")

        await fulfillment(of: [exp] ,timeout: 3)
    }

    func test_performRequest_invalidResponse() async throws {
        // Given
        let exp = expectation(description: "Perform Request")
        let invalidStatusCode = 404
        let mockRequest = getMockRequest()
        var errorResult: Error?
        TestURLProtocol.stubResponse(statusCode: invalidStatusCode)

        // When
        do {
            let _ = try await sut.perform(mockRequest)
            XCTFail("Expected an error to be thrown")
        } catch {
            errorResult = error
            exp.fulfill()
        }

        // Then
        XCTAssertNotNil(errorResult)
        XCTAssertEqual(errorResult as? NetworkError, NetworkError.invalidResponse)
        await fulfillment(of: [exp], timeout: 10)
    }

    func test_performRequest_getCorrectData() async throws {
        // Given
        let exp = expectation(description: "Perform request and get correct data")
        let mockRecipe = getMockRecipe()
        let mockRequest = getMockRequest()
        let mockData = try JSONEncoder().encode(mockRecipe)
        TestURLProtocol.lastRequest = nil
        TestURLProtocol.mockData = mockData
        TestURLProtocol.response = HTTPURLResponse(
            url: URL(string: "http://demo4677561.mockable.io/recipes_world")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        TestURLProtocol.stubResponse(statusCode: 200)
        TestURLProtocol.error = nil

        // When
        let data = try await sut.perform(mockRequest)
        let decodedRecipe = try JSONDecoder().decode(Recipe.self, from: data)

        // Then
        XCTAssertEqual(decodedRecipe, mockRecipe)
        exp.fulfill()
        await fulfillment(of: [exp] ,timeout: 3)
    }

    private func getMockRecipe() -> Recipe {
        return Recipe(
            name: "Pizza Margherita",
            country: "Italy",
            flagIcon: "🇮🇹",
            ingredients: [
                "1 pizza dough",
                "1/2 cup tomato sauce",
                "2 cups mozzarella cheese",
                "Fresh basil leaves",
                "Olive oil",
                "Salt"
            ],
            steps: [
                "Preheat the oven to 475°F (245°C).",
                "Roll out the pizza dough into a thin circle.",
                "Spread the tomato sauce evenly on the dough.",
                "Sprinkle the mozzarella cheese over the sauce.",
                "Tear the fresh basil leaves and distribute them on top.",
                "Drizzle olive oil and sprinkle salt over the pizza.",
                "Bake in the preheated oven for 12-15 minutes, or until the crust is golden and the cheese is bubbly and slightly browned.",
                "Remove from the oven, let it cool for a few minutes, and serve."
            ],
            servings: "1 large pizza",
            prepTime: "30 minutes",
            imageURL: "https://images.unsplash.com/photo-1598023696416-0193a0bcd302?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8UGl6emElMjBNYXJnaGVyaXRhfGVufDB8fDB8fHww&auto=format&fit=crop&w=900&q=60")
    }

    private func getMockRequest() -> RequestProtocol {
        struct MockRequest: RequestProtocol {
            let path: String = "/recipes_world"
            let headers: [String: String] = ["Content-Type": "application/json"]
            let params: [String: Any] = [:]
            let urlParams: [String: String?] = [:]
            let requestType: RequestType = .GET
        }
        return MockRequest()
    }
}
