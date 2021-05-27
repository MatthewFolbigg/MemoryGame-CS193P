//
//  EmojiMemoryGame.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 27/05/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let fruitEmojis = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥝"]
    private static let animalEmojis = ["🐶", "🦊", "🐻", "🐼", "🐨", "🐯", "🐮", "🐷"]
    private static let vehicleEmojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🏍", "🛺", "🚠", "🚃", "🚂", "🚀", "🚁", "🛶", "⛵️", "🚤", "🚲", "🛵"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfCardPairs: 6) { pairIndex in
            //let randomSelectionFromTheme = theme.shuffled().prefix(numberOfCards)
            return fruitEmojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    //MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        //objectWillChange.send() //@Published mark on the model var calls this automatically
        model.choose(card)
    }
    
    
    
}
