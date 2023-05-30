//
//  HomeView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 27/05/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            Text("My Recipes")
                .navigationTitle("Recipes")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
