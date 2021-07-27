//
//  EmojiMemoryGame.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 27/05/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
        
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let numberOfPairs = min(theme.numberOfPairs, theme.emoji.count)
        let shuffledEmoji = theme.emoji.shuffled()
        var memoryGame = MemoryGame<String>(numberOfCardPairs: numberOfPairs) { pairIndex in
            return shuffledEmoji[pairIndex]
        }
        memoryGame.shuffle()
        return memoryGame
    }
        
    //MARK: - Public Variables
    
    @Published private var model: MemoryGame<String>
    @Published var dealtCardIds = Set<Int>()
    
    var theme: Theme 
    
    var cards: [Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var maxScore: Int {
        cards.count
    }
    
    var isWon: Bool {
        model.gameState == .finished ? true : false
    }
    
    var isPendingDeal: Bool {
        model.gameState == .pendingDeal && dealtCardIds.count == 0 ? true : false
    }
    
    var colour: Color {
        return theme.color
    }
    
    init(theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme: self.theme)
    }
    
    //MARK: - Intents
    
    func choose(_ card: Card) {
        //objectWillChange.send() //@Published mark on the model var calls this automatically
        model.choose(card)
    }
    
    func newGame() {
        self.model = EmojiMemoryGame.createMemoryGame(theme: self.theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
}
