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
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: bestCardWidthFor(numberOfCards: game.cards.count)))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
                .padding(.horizontal)
            }
            .foregroundColor(game.colour)
            Button(action: {
                game.newGame()
            }, label: {
                Image(systemName: "arrow.counterclockwise.circle")
                Text("New Game")
            })
        }
    }
        
    func bestCardWidthFor(numberOfCards: Int) -> CGFloat {
        if numberOfCards <= 4 {
            return 125
        } else if numberOfCards <= 8 {
            return 100
        } else if numberOfCards <= 12 {
            return 75
        } else if numberOfCards <= 24 {
            return 55
        } else {
            return 50
        }
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 mini")
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 mini")
    }
}
