//
//  RecipeDetailView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 31/05/23.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let recipe: Recipe
    
    var body: some View {
        NavigationStack {
            ScrollView {
                AsyncImage(url: URL(string: recipe.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
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
                .frame(height: 300)
                .clipped()
                .background(LinearGradient(
                    gradient:
                        Gradient(colors: [Color.gray.opacity(0.3), Color.gray]),
                    startPoint: .top, endPoint: .bottom))
                RecipeDescriptionView(recipe: recipe)
            }
        }
        .modifier(BackgroundGradient(
            startColor: Color(hex: "#3C3190"),
            endColor: Color(hex: "#120D38")))
        .modifier(NavigationBarModifier(
            color: Color(hex: "#3C3190"), opacity: 0.1))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            NavigationLink(
                destination: MapView(recipe: recipe)) {
                    Image(systemName: "map")
                }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe.stubbedRecipes[0])
    }
}
