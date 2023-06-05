//
//  RecipeStore.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 30/05/23.
//

import Foundation

class RecipeStore: RecipeRequestServiceProtocol {
    static let shared = RecipeStore()
    private let requestManager = RequestManagerService()

    private init() {}

    func getRecipes(from request: RecipeRequest) async throws -> RecipeResponse {
        do {
            return try await requestManager.perform(request)
        } catch {
            throw RecipeRequestError.APIError
        }
    }
}
