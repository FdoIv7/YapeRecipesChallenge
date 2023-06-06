//
//  RecipeList.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 31/05/23.
//

import SwiftUI

struct RecipeList: View {

    @EnvironmentObject var viewModel: RecipesViewModel
    let otherRecipes = Recipe.stubbedRecipes
    
    var body: some View {
        VStack {
            TextField(
                "Search recipe or ingredients",
                text: $viewModel.searchText)
                .padding()
                .frame(height: 50)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(.top)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)]) {
                ForEach(viewModel.filteredRecipes()) { recipe in
                    NavigationLink(
                    destination: RecipeDetailView(
                        recipe: recipe)) {
                        RecipeCardView(recipe: recipe)
                    }
                }
            }
            .padding([.top, .bottom], 16)
        }
        .padding(.horizontal)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            RecipeList()
                .environmentObject(RecipesViewModel())
        }
    }
}
