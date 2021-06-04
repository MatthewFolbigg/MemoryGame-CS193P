//
//  CardView.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 04/06/2021.
//

import Foundation
import SwiftUI

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius, style: .continuous)
                if card.isFaceUp {
                    cardShape.fill().foregroundColor(.white)
                    cardShape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120-90))
                        .padding(DrawingConstants.timerPadding)
                        .opacity(DrawingConstants.timerOpacity)
                    Text(card.content)
                        .font(font(scaledTo: geometry.size))
                } else if card.isMatched {
                    cardShape.opacity(DrawingConstants.matchedOpacity)
                } else {
                    cardShape.fill()
                }
            }
        }
    }
    
    private func font(scaledTo size: CGSize) -> Font {
        Font.system(size: min(size.height, size.width) * DrawingConstants.fontScale)
    }

    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.55
        static let matchedOpacity: Double = 0.2
        static let timerOpacity: Double = 0.3
        static let timerPadding: CGFloat = 6
    }

}
