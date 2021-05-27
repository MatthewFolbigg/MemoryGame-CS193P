//
//  ContentView.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 18/05/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameViewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            Text("Memoji")
                .font(.title)
                .fontWeight(.light)
                .foregroundColor(.primary)
                .padding(.top)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: bestCardWidthFor(numberOfCards: gameViewModel.cards.count)))]) {
                    ForEach(gameViewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                gameViewModel.choose(card)
                            }
                    }
                }
                .padding(.horizontal)
            }
            .foregroundColor(.green)
        }
    }
    
//    @ViewBuilder func themeButton(name: String, systemImage: String, theme: [String]) -> some View {
//        let numberOfCards = Int.random(in: 4..<theme.count)
//        Button(action: {
//            self.numberOfCards = numberOfCards
//            let randomSelectionFromTheme = theme.shuffled().prefix(numberOfCards)
//            self.emojis = Array(randomSelectionFromTheme)
//        }, label: {
//            VStack {
//                Image(systemName: systemImage)
//                Text(name).font(.caption)
//            }
//        })
//    }
    
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

struct CardView: View {
    let card: MemoryGame<String>.Card
    var body: some View {
        ZStack() {
            let cardShape = RoundedRectangle(cornerRadius: 15, style: .continuous)
            if card.isFaceUp {
                cardShape.fill().foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                cardShape.opacity(0.2)
            } else {
                cardShape.fill()
            }
        }
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(gameViewModel: game)
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 mini")
        ContentView(gameViewModel: game)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 mini")
    }
}
