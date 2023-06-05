//
//  RecipeCardView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 30/05/23.
//

import SwiftUI

struct RecipeCardView: View {
    var recipe: Recipe?
    
    var body: some View {
        VStack {
            if let recipe = recipe {
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
        .frame(width: 170, height: 270, alignment: .top)
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: [Color.gray.opacity(0.3), Color.gray]),
                startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(
            cornerRadius: 20,
            style: .continuous))
        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: Recipe.stubbedRecipes[0])
    }
}
