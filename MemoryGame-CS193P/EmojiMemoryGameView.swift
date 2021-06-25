//
//  EmojiMemoryGameView.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 18/05/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack{
            HStack(alignment: .firstTextBaseline) {
                Text("\(game.theme.emoji[0]) \(game.theme.name)")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(game.colour)
                Spacer()
                Text("Score: \(game.score)")
                    .font(.title2)
            }
            .padding(.top)
            .padding(.horizontal)
            //MARK: -
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    EmojiCardView(card: card)
                        .opacity(0.1)
                } else {
                    EmojiCardView(card: card)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            
            .foregroundColor(game.colour)
            .padding(.horizontal)
            //MARK: -
            Button(action: {
                game.newGame()
            }, label: {
                Image(systemName: "arrow.counterclockwise.circle")
                Text("New Game")
            })
        }
    }
            
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 mini")
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
//            .previewDevice("iPhone 12 mini")
    }
}
