//
//  RecipeRequestMock.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 29/05/23.
//

import Foundation
@testable import YapeRecipesChallenge

enum RecipesRequestMock: RequestProtocol {
    case getRecipes

    var requestType: RequestType {
        return .GET
    }

    var headers: [String : String] { [:] }

    var path: String {
        guard let path = Bundle.main.path(forResource: "MockRecipes", ofType: "json")
        else { return "" }
        return path
    }
}
