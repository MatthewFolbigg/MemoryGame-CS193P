//
//  Cardify.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 25/06/2021.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack() {
            let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius, style: .continuous)
            if isFaceUp {
                cardShape.fill().foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                cardShape.fill()
            }
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let matchedOpacity: Double = 0.2
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}


