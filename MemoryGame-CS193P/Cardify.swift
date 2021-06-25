//
//  Cardify.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 25/06/2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    var rotation: Double //degrees
    
    func body(content: Content) -> some View {
        ZStack() {
            let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius, style: .continuous)
            if rotation < 90 {
                cardShape.fill().foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                cardShape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(
            Angle(degrees: rotation),
            axis: (0, 1, 0)
        )
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


