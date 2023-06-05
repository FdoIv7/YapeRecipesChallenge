//
//  ContentView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 27/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        HomeView()
            .environmentObject(imageLoader)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
