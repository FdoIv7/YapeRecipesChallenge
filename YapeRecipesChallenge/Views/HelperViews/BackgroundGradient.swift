//
//  BackgroundGradient.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 05/06/23.
//

import SwiftUI

struct BackgroundGradient: ViewModifier {
    var startColor: Color
    var endColor: Color
    var opacity: CGFloat = 1
    
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(
                gradient: Gradient(colors: [startColor, endColor]),
                startPoint: .top,
                endPoint: .bottom))
            .opacity(opacity)
    }
}

