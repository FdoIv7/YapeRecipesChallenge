//
//  HomeView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 27/05/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel = RecipesViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let _ = viewModel.recipes {
                        RecipeList()
                            .environmentObject(viewModel)
                    } else {
                        Spacer()
                        Text("Getting recipes...")
                            .font(.headline)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                        ProgressView()
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Recipes")
            .modifier(BackgroundGradient(
                startColor: Color(hex: "#3C3190"),
                endColor: Color(hex: "#120D38")))
            .modifier(NavigationBarModifier(
                color: Color(hex: "#3C3190"), opacity: 0.1))
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
