//
//  RecipeRequest.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 30/05/23.
//

import Foundation

enum RecipeRequest: RequestProtocol {
    case getWorldRecipes
    
    var requestType: RequestType {
        .GET
    }
    
    var path: String {
        switch self {
        case .getWorldRecipes: return Constants.Networking.Endpoints.recipes
        }
    }
}
