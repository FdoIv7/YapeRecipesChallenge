//
//  TextView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 02/06/23.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    let text: String

    func makeUIView(context: Context) -> some UIView {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.text = text
        textView.textAlignment = .justified
        return textView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let view = uiView as? UITextView {
            view.text = text
        }
        
    }
}
