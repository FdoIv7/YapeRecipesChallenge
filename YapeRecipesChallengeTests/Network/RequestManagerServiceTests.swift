//
//  RequestManagerServiceTests.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 29/05/23.
//

import XCTest
@testable import YapeRecipesChallenge

class RequestManagerServiceTests: XCTestCase {
    private var sut: RequestManagerServiceProtocol?

    override func setUp() {
        super.setUp()
        guard let userDefaults = UserDefaults(suiteName: #file) else { return }
        userDefaults.removePersistentDomain(forName: #file)
        sut = createService()
    }

    private func createService() -> RequestManagerServiceProtocol {
        return RequestManagerService(apiManager: APIManagerMock())
    }

    func test_requestRecipes() async throws {
        // Given
        guard let response: RecipeResponse = try await sut?.perform(RecipesRequestMock.getRecipes) else {
            XCTFail("Didn't get any data from request manager")
            return
        }
        let recipes = response.recipes

        // When
        let first = recipes.first
        let last = recipes.last

        // Then
        XCTAssertEqual(first?.name, "Pizza Margherita")
        XCTAssertEqual(first?.country, "Italy")
        XCTAssertEqual(first?.ingredients.count, 6)
        XCTAssertEqual(first?.steps.count, 8)

        XCTAssertEqual(last?.name, "Goulash")
        XCTAssertEqual(last?.country, "Hungary")
        XCTAssertEqual(last?.ingredients.count, 13)
        XCTAssertEqual(last?.steps.count, 8)
    }
}
