//
//  RecipeList.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 31/05/23.
//

import SwiftUI

struct RecipeList: View {
    var recipes: [Recipe]
    let otherRecipes = Recipe.stubbedRecipes
    
    var body: some View {
        VStack {
            HStack {
                Text("\(recipes.count) \(recipes.count > 1 ? "recipes" : "recipe")")
                    .font(.headline)
                    .fontWeight(.medium)
                    .opacity(0.7)
                Spacer()
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)]) {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
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
            RecipeList(recipes: Recipe.stubbedRecipes)
        }
    }
}
