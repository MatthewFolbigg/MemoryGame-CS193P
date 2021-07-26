//
//  ThemeStore.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 23/07/2021.
//

import SwiftUI

class ThemeStore: ObservableObject {
    
    var storeName: String
    var userDefaultsKey: String { "themeStore\(storeName)" }
    
    @Published var themes: [Theme] = [] {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private func storeInUserDefaults() {
        let json = try? JSONEncoder().encode(themes)
        UserDefaults.standard.set(json, forKey: userDefaultsKey)
        print("Saved Themes")
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let decodedPalettes = try? JSONDecoder().decode([Theme].self, from: jsonData) {
                print("Loaded Themes")
                self.themes = decodedPalettes
            }
        }
    }
    
    init(named: String) {
        storeName = named
        restoreFromUserDefaults()
        if themes.isEmpty {
            print("Set Default Themes")
            themes = DefaultThemes.allThemes
        }
    }
    
    //MARK: - Intents
    func addTheme() {
        let themeColor = ThemeColor(red: 53/255, green: 120/255, blue: 247/255, alpha: 1.0)
        let newTheme = Theme(name: "New Theme", emoji: ["🔵", "🔷"], numberOfPairs: 2, colour: themeColor)
        themes.append(newTheme)
    }
    
}

//MARK: - Default Themes
struct DefaultThemes {
    static let allThemes: [Theme] = [fruit, vehicle, animal, nature, sport, object]
    
    static let fruit = Theme(
        name: "Fruits",
        emoji: ["🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥝"],
        numberOfPairs: 15,
        colour: ThemeColor(red: 235/255, green: 77/255, blue: 62/255, alpha: 1.0)
    )
    
    static let vehicle = Theme(
        name: "Vehicles",
        emoji: ["🚙", "🚕", "🚗", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🏍", "🛺", "🚠", "🚃", "🚂", "🚀", "🚁", "🛶", "⛵️", "🚤", "🚲", "🛵"],
        numberOfPairs: 15,
        colour: ThemeColor(red: 53/255, green: 120/255, blue: 247/255, alpha: 1.0)
    )
    
    static let animal = Theme(
        name: "Animals",
        emoji: ["🦊", "🐶", "🐻", "🐼", "🐨", "🐯", "🐮", "🐷"],
        colour: ThemeColor(red: 241/255, green: 154/255, blue: 56/255, alpha: 1.0)
    )
    
    static let nature = Theme(
        name: "Nature",
        emoji: ["🌲", "🌵"],
        colour: ThemeColor(red: 101/255, green: 196/255, blue: 102/255, alpha: 1.0)
    )
    
    static let sport = Theme(
        name: "Sport",
        emoji: ["🎾", "⚽️", "🏈"],
        colour: ThemeColor(red: 247/255, green: 206/255, blue: 70/255, alpha: 1.0)
    )

    static let object = Theme(
        name: "Objects",
        emoji: ["🔮", "💡", "🧨", "💿", "📺", "🔭"],
        colour: ThemeColor(red: 164/255, green: 87/255, blue: 215/255, alpha: 1.0)
    )
}
