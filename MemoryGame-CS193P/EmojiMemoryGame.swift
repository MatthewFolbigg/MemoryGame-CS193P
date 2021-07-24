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
        var memoryGame = MemoryGame<String>(numberOfCardPairs: numberOfPairs) { pairIndex in
            return theme.emoji[pairIndex]
        }
        memoryGame.shuffle()
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
        print(self.model.gameState)
        if model.gameState == .finished {
            return true
        } else {
            return false
        }
    }
    
    //MARK:- This is currently duplcated in ThemeChooser. Remove One?
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
