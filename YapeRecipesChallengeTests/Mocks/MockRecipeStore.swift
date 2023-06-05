//
//  MockRecipeStore.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 30/05/23.
//

import Foundation
@testable import YapeRecipesChallenge

internal class MockRecipeStore: RecipeRequestServiceProtocol {
    static let shared = MockRecipeStore()
    var requestManager: RequestManagerServiceProtocol!

    private init() { }

    func getRecipes(from request: RecipeRequest) async throws -> RecipeResponse {
        do {
            return try await requestManager.perform(request)
        } catch {
            throw RecipeRequestError.APIError
        }
    }

    func setRequestManager(requestManager: RequestManagerServiceProtocol) {
        self.requestManager = requestManager
    }
}
