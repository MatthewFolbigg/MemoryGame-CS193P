//
//  Theme.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 02/06/2021.
//

import SwiftUI

struct Theme: Equatable, Identifiable, Codable {
    let id: UUID
    var name: String
    var emoji: [String]
    var numberOfPairs: Int
    var colourData: ThemeColor
        
    init(name: String, emoji: [String], numberOfPairs: Int? = nil, colour: ThemeColor) {
        self.name = name
        self.emoji = emoji
        let specifiedPairCount = numberOfPairs ?? emoji.count
        self.numberOfPairs = specifiedPairCount
        self.colourData = colour
        self.id = UUID()
    }
    
    var color: Color {
        get {
            let rgb = self.colourData
            let uiColor = UIColor(red: CGFloat(rgb.red), green: CGFloat(rgb.green), blue: CGFloat(rgb.blue), alpha: CGFloat(rgb.alpha))
            return Color(uiColor)
        }
        set {
            let cg = UIColor(newValue).cgColor
            if let components = cg.components {
                self.colourData = ThemeColor(red: Double(components[0]), green: Double(components[1]), blue: Double(components[2]), alpha: Double(components[3]))
            }
        }
    }
}

struct ThemeColor: Codable, Equatable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}
