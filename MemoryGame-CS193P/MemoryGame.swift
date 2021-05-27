//
//  MemoryGame.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 27/05/2021.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    
    private(set) var cards: [Card]
    
    private var indexOfTheOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let faceUpIndex = indexOfTheOnlyFaceUpCard {
                if cards[faceUpIndex].content == cards[chosenIndex].content {
                    cards[faceUpIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                }
                indexOfTheOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfCardPairs: Int, createContentForPair: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfCardPairs {
            let content = createContentForPair(pairIndex)
            let id1 = pairIndex*2
            let id2 = pairIndex*2+1
            cards.append(Card(id: id1, content: content))
            cards.append(Card(id: id2, content: content))
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
