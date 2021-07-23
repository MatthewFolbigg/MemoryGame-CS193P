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
        let randomEmoji = theme.emoji.shuffled()
        let numberOfPairs = min(theme.numberOfPairs, theme.emoji.count)
        let memoryGame = MemoryGame<String>(numberOfCardPairs: numberOfPairs) { pairIndex in
            return randomEmoji[pairIndex]
        }
        return memoryGame
    }
        
    //MARK: - Public Variables
    
    @Published private var model: MemoryGame<String>
    
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
        if model.gameState == .won {
            return true
        } else {
            return false
        }
    }
    
    var colour: Color {
        switch theme.colour {
        case "red" : return Color.red
        case "blue" : return Color.blue
        case "orange" : return Color.orange
        case "green" : return Color.green
        case "yellow" : return Color.yellow
        case "purple" : return Color.purple
        default: return Color.green
        }
    }
    
    init() {
        self.theme = emojiThemes.allThemes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(theme: self.theme)
    }
    
    //MARK: - Intents
    
    func choose(_ card: Card) {
        //objectWillChange.send() //@Published mark on the model var calls this automatically
        model.choose(card)
    }
    
    func newGame() {
        self.theme = emojiThemes.allThemes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(theme: self.theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
}
