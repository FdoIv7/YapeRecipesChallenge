//
//  RecipeRequestService.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 30/05/23.
//

import Foundation

protocol RecipeRequestServiceProtocol {
    func getRecipes(from: RecipeRequest) async throws -> RecipeResponse
}

enum RecipeRequestError: Error {
    case APIError
    case invalidEndpoint
    case invalidResponse
    case noData

    var localizedDescription: String {
        switch self {
        case .APIError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data from server"
        }
    }
}
