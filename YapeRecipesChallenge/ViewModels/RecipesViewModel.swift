//
//  RecipesViewModel.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 30/05/23.
//

import Foundation

class RecipesViewModel: ObservableObject {
    private let recipeService: RecipeRequestServiceProtocol
    @Published var recipes: [Recipe]?

    init(recipeService: RecipeRequestServiceProtocol = RecipeStore.shared) {
        self.recipeService = recipeService
    }

    @MainActor
    func fetchWorldRecipes() async throws {
        self.recipes = nil
        do {
            self.recipes = try await recipeService.getRecipes(from: RecipeRequest.getWorldRecipes).recipes
        } catch {
            throw DataError.noData
        }
    }
}

// Maybe this can be a view
struct RecipeCardViewModel: Identifiable {
    let id = UUID()
    private let recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    var title: String {
        recipe.name
    }

    var imageURL: URL? {
        URL(string: recipe.imageURL )
    }
}
