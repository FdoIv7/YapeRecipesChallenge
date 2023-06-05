//
//  Recipe+Extension.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 30/05/23.
//

import Foundation

extension Recipe {
    static var stubbedRecipes: [Recipe] {
        guard
            let url = Bundle.main.url(forResource: "recipes", withExtension: "json"),
            let data = try? Data(contentsOf: url) else { return [] }
        return (try? data.transforming(type: RecipeResponse.self).recipes) ?? []
    }
}
