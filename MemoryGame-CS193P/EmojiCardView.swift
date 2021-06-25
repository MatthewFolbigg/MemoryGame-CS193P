//
//  CardView.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 04/06/2021.
//

import Foundation
import SwiftUI

struct EmojiCardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120-90))
                    .padding(DrawingConstants.timerPadding)
                    .opacity(DrawingConstants.timerOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 720 : 0))
                    .animation(.easeInOut)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
        
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }

    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.55
        static let fontSize: CGFloat = 30
        static let timerOpacity: Double = 0.3
        static let timerPadding: CGFloat = 6
    }

}
