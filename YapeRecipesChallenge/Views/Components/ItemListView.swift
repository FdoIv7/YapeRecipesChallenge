//
//  ItemListView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 03/06/23.
//

import SwiftUI

struct ItemListView: View {
    let title: String
    var numbered: Bool = false
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            VStack(alignment: .leading, spacing: 8) {
                ForEach(items.indices, id: \.self) { index in
                    HStack(alignment: .firstTextBaseline) {
                        if numbered {
                            Text("\(index + 1).")
                                .bold()
                                .font(.subheadline)
                        } else {
                            Text("•")
                        }
                        Text(items[index])
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding([.leading, .trailing], 16)
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(title: "Directions", numbered: true, items: Recipe.stubbedRecipes[4].steps)
    }
}
