//
//  HomeView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 27/05/23.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject private var viewModel = RecipesViewModel()
    @EnvironmentObject private var imageLoader: ImageLoader
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let recipes = viewModel.recipes {
                        RecipeList(recipes: recipes)
                    } else {
                        RecipeCardView(recipe: nil)
                    }
                }
            }
            .navigationTitle("Recipes")
        }
        .tint(.white)
        .onAppear {
            getRecipes()
        }
    }

    
    private func getRecipes() {
        Task {
            try await viewModel.fetchWorldRecipes()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
