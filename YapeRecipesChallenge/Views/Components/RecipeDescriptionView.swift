//
//  RecipeDescriptionView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 03/06/23.
//

import SwiftUI

struct RecipeDescriptionView: View {
    let recipe: Recipe

    var body: some View {
        VStack(spacing: 20) {
            Text(recipe.name)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center )
            VStack(alignment: .leading, spacing: 20) {
                Text(recipe.description)
                    .padding([.leading, .trailing], 12)
                ItemListView(
                    title: "Ingredients:",
                    items: recipe.ingredients)
                ItemListView(
                    title: "Directions:",
                    numbered: true,
                    items: recipe.steps)
            }
        }
        .foregroundColor(.white)
    }
}

struct RecipeDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDescriptionView(recipe: Recipe.stubbedRecipes[5])
    }
}
