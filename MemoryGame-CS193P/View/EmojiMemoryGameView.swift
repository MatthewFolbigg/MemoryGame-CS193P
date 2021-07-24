//
//  EmojiMemoryGameView.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 18/05/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNameSpace
        
    var body: some View {
        VStack{
            topBar
            ZStack(alignment: .bottom) {
                if game.isWon {
                    winMessage
                } else {
                    gameBody
                    VStack {
                        deckBody
                        bottomBar
                    }
                }
            }
        }
        .navigationTitle("\(game.theme.emoji[0]) \(game.theme.name)")
    }
    
    private func dealCards() {
        for card in game.cards {
            withAnimation(dealAnimation(for: card)) {
                deal(card: card)
            }
        }
    }
    
    //MARK: - Game Body
    @State private var dealtCardIds = Set<Int>()
    
    private func deal(card: EmojiMemoryGame.Card) {
        dealtCardIds.insert(card.id)
    }
    
    private func isNotDealt(card: EmojiMemoryGame.Card) -> Bool {
        !dealtCardIds.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {card.id == $0.id} ) {
            delay = Double(index) * (DrawingConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: DrawingConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(for card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var winMessage: some View {
        VStack {
            Spacer()
            Text("You Win!")
                .font(.title)
                .fontWeight(.semibold)
            Text("Scoring \(game.score) of a possible \(game.maxScore).")
                .font(.title3)
                .fontWeight(.light)
            newGameButton
                .frame(width: 160, height: 40, alignment: .center)
                .background(game.colour)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.vertical)
            Spacer()
            Spacer()
        }
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isNotDealt(card: card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                EmojiCardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(for: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(game.colour)
        .padding(.horizontal)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isNotDealt)) { card in
                EmojiCardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(for: card))
            }
        }
        .frame(width: DrawingConstants.deckWidth, height: DrawingConstants.deckHeight)
        .foregroundColor(game.colour)
        .onTapGesture {
            dealCards()
        }
    }
    
    //MARK: - Top Bar
    var topBar: some View {
        HStack {
            Text("Score: \(game.score)")
                .font(.title2)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    //MARK: - Bottom Bar
    var bottomBar: some View {
        VStack {
            shuffleButton
                .padding(/*@START_MENU_TOKEN@*/.vertical, 4.0/*@END_MENU_TOKEN@*/)
            newGameButton
                .foregroundColor(game.colour)
        }
        .padding(.horizontal, 0.0)
    }
    
    var newGameButton: some View {
        Button(action: {
            withAnimation {
                dealtCardIds = []
                game.newGame()
            }
        }, label: {
            Image(systemName: "arrow.counterclockwise.circle")
            Text("Restart")
        })
    }
    
    var shuffleButton: some View {
        Button(action: {
            withAnimation {
                game.shuffle()
            }
        }, label: {
            Image(systemName: "shuffle.circle")
            Text("Shuffle")
        })
        .frame(width: 160, height: 40, alignment: .center)
        .background(game.colour)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
    //MARK: - Constants
    struct DrawingConstants {
        static let deckWidth = deckHeight * aspectRatio
        static let deckHeight: CGFloat = 90
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 1.5
    }

    
            
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(theme: EmojiThemes.animal)
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 mini")
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
//            .previewDevice("iPhone 12 mini")
    }
}
