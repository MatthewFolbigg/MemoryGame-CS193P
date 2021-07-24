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
    
    enum GameState {
        case inProgress
        case finished
        case pendingDeal
    }
    
    var gameState: GameState = .pendingDeal
    
    private var indexOfTheOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
        
    mutating func choose(_ card: Card) {
        gameState = .inProgress
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
                if (cards.indices.filter({ !cards[$0].isMatched }).count == 0) {
                    print("Win")
                    gameState = .finished
                } else {
                    print("Keep going")
                }
            } else {
                //Card is the first of 2 to be turned over
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].hasBeenSeen = true
            print("\(score) of a possible \(cards.count)")
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
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
        var isMatched = false
        var hasBeenSeen = false
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }


        // MARK: - Bonus Time
            // MARK: This section of code is not my own it was provided by the CS193p team as part of lecture 8
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        // MARK: - End of code provided by CS193p lecture 8
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
