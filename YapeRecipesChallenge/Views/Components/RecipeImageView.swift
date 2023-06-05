//
//  AsyncImageView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 31/05/23.
//

import SwiftUI

struct RecipeImageView: View {

    let recipe: Recipe
    
    var body: some View {
        AsyncImage(
            url: URL(string: recipe.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom) {
                        Text(recipe.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 5)
                            .frame(maxWidth: 150)
                            .padding(.bottom)
                    }
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 40,
                        height: 40,
                        alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity)
            }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeImageView(recipe: Recipe.stubbedRecipes[2])
    }
}
