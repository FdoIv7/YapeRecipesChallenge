//
//  SplashView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 05/06/23.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient:
                    Gradient(colors: [
                        Color(hex: "#3C3190"),
                        Color(hex: "#120D38")]),
                startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("RecipifyLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Text("Recipify")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }   
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
