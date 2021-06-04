//
//  MemoryGame.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 27/05/2021.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    
    private(set) var cards: [Card]
    private(set) var score: Int = 0
    
    private var indexOfTheOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
        
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let faceUpIndex = indexOfTheOnlyFaceUpCard {
                //Checks for match
                if cards[faceUpIndex].content == cards[chosenIndex].content {
                    cards[faceUpIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].hasBeenSeen { score -= 1 }
                    if cards[chosenIndex].hasBeenSeen { score -= 1 }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                //Card is the first of 2 to be turned over
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].hasBeenSeen = true
            print("\(score) of a possible \(cards.count)")
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
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        let id: Int
        let content: CardContent
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
