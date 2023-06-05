//
//  MapRecipeCardView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 04/06/23.
//

import SwiftUI

struct MapRecipeCardView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                AsyncImage(url: URL(string: recipe.imageURL)) { image in
                    image
                        .resizable()
                        .clipShape(RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous))
                        .padding([.leading, .top, .bottom], 16)
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
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .bold()
                        .foregroundColor(.white)
                    Text(recipe.origin.country)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .bold()
                    Text(recipe.origin.flagIcon)
                }
                .offset(x: -20)
                .font(.title3)
                .frame(maxWidth: .infinity)
                .padding()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(
                        colors: [Color.gray.opacity(0.3), Color.gray]),
                    startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(
                cornerRadius: 20,
                style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
            .padding()
        }
    }
}
struct MapRecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        MapRecipeCardView(recipe: Recipe.stubbedRecipes[9])
    }
}
