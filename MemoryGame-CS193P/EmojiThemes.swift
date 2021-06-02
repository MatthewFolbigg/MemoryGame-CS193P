//
//  EmojiThemes.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 02/06/2021.
//

import Foundation

struct emojiThemes {
    static let allThemes: [Theme] = [fruit, vehicle, animal, nature, sport, object]
    
    static let fruit = Theme(
        name: "Fruits",
        emoji: ["🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥝"],
        numberOfPairs: 15,
        colour: "red"
    )
    
    static let vehicle = Theme(
        name: "Vehicles",
        emoji: ["🚙", "🚕", "🚗", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🏍", "🛺", "🚠", "🚃", "🚂", "🚀", "🚁", "🛶", "⛵️", "🚤", "🚲", "🛵"],
        numberOfPairs: 15,
        colour: "blue"
    )
    
    static let animal = Theme(
        name: "Animals",
        emoji: ["🦊", "🐶", "🐻", "🐼", "🐨", "🐯", "🐮", "🐷"],
        colour: "orange"
    )
    
    static let nature = Theme(
        name: "Nature",
        emoji: ["🌲", "🌵"],
        colour: "green"
    )
    
    static let sport = Theme(
        name: "Sport",
        emoji: ["🎾", "⚽️", "🏈"],
        colour: "yellow"
    )
    
    static let object = Theme(
        name: "Objects",
        emoji: ["🔮", "💡", "🧨", "💿", "📺", "🔭"],
        colour: "purple"
    )
    
}

struct Theme {
    let name: String
    let emoji: [String]
    let numberOfPairs: Int
    let colour: String
    
    init(name: String, emoji: [String], colour: String) {
        self.name = name
        self.emoji = emoji
        self.numberOfPairs = emoji.count
        self.colour = colour
    }
    
    init(name: String, emoji: [String], numberOfPairs: Int, colour: String) {
        self.name = name
        self.emoji = emoji
        self.numberOfPairs = numberOfPairs
        self.colour = colour
    }
    
}
