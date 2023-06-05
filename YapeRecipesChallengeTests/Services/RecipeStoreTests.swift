//
//  RecipeStoreTests.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 30/05/23.
//

import Foundation
import XCTest
@testable import YapeRecipesChallenge

class RecipeStoreTests: XCTestCase {
    var sut: MockRecipeStore!
    var mockRequestService: RecipeRequestServiceProtocol!

    override func setUp() {
        super.setUp()
        sut = MockRecipeStore.shared
    }

    func test_getRecipes_correctRequest() async throws {
        // Given
        let expectedRequest = RecipeRequest.getWorldRecipes
        let response = RecipeResponse(recipes: [])
        let mockRequestManager = MockRequestManager(mockedResponse: response)

        // When
        sut.setRequestManager(requestManager: mockRequestManager)
        _ = try await sut.getRecipes(from: expectedRequest)
        
        // Then
        XCTAssertEqual(mockRequestManager.lastRequest?.requestType, .GET)
        XCTAssertEqual(mockRequestManager.lastRequest?.path, Constants.Networking.Endpoints.recipes)
    }
    
    func test_getRecipes_correctResponse() async throws {
        // Given
        let request = RecipeRequest.getWorldRecipes
        let expectedResponse = RecipeResponse(recipes: getMockRecipes().recipes)
        let mockRequestManager = MockRequestManager(mockedResponse: getMockRecipes())

        // When
        sut.setRequestManager(requestManager: mockRequestManager)
        let actualResponse = try await sut.getRecipes(from: request)
        
        // Then
        XCTAssertEqual(actualResponse, expectedResponse)
    }

    internal func getMockRecipes() -> RecipeResponse {
        let recipe = Recipe(
            name: "Pizza Margherita",
            description: "Indulge in the irresistible flavors of Pizza Margherita, a classic Italian masterpiece. This mouthwatering pizza features a thin and crispy crust topped with tangy tomato sauce, generous amounts of gooey mozzarella cheese, and a sprinkle of fresh basil leaves for a burst of freshness. Buon appetito!",
            origin: RecipeOrigin(country: "Italy", flagIcon: "🇮🇹", city: "Rome"),
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
            imageURL: "https://example.com/pizza_margherita.jpg"
        )
        
        let response = RecipeResponse(recipes: [recipe])
        return response
    }
}

class MockRequestManager: RequestManagerServiceProtocol {
    var mockedResponse: RecipeResponse?
    var mockedError: Error?
    var lastRequest: RequestProtocol?

    init(mockedResponse: RecipeResponse? = nil, mockedError: Error? = nil) {
        self.mockedResponse = mockedResponse
        self.mockedError = mockedError
    }
    
    func perform<RecipeResponse>(_ request: RequestProtocol) async throws -> RecipeResponse {
        self.lastRequest = request

        if let error = mockedError {
            throw error
        }
        guard let response = mockedResponse as? RecipeResponse else {
            throw RecipeRequestError.invalidResponse
        }
        return response
    }
}
