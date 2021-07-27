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
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                    .padding(DrawingConstants.timerPadding)
                    .opacity(DrawingConstants.timerOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.easeInOut)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            .shadow(radius: 2)
            .shadow(color: Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.1), radius:4)
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
