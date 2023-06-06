//
//  NavigationBarModifier.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 05/06/23.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    let color: Color
    let opacity: Double

    func body(content: Content) -> some View {
        content
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                color.opacity(opacity),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
