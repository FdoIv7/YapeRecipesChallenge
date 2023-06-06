//
//  YapeRecipesChallengeApp.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 27/05/23.
//

import SwiftUI

@main
struct YapeRecipesChallengeApp: App {
    
    @State private var showSplashScreen = true
    
    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSplashScreen = false
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
}
