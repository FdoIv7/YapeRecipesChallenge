//
//  Color+Extensions.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 05/06/23.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        guard let hexValue = UInt64(hexString, radix: 16) else {
            self.init(.black)
            return
        }
        
        let r = Double((hexValue & 0xFF0000) / 0x10000) / 255.0
        let g = Double((hexValue & 0x00FF00) / 0x100) / 255.0
        let b = Double(hexValue & 0x0000FF) / 255.0
        
        self.init(
            .sRGB,
            red: r,
            green: g,
            blue: b,
            opacity: 1.0
        )
    }
}
