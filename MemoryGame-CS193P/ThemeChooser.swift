//
//  ThemeChooser.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 23/07/2021.
//

import SwiftUI

class ThemeChooser: ObservableObject {
    
    @Published var themes: [Theme]
    
    init() {
        themes = EmojiThemes.allThemes
    }
    
    //MARK:- This is currently duplcated in EmojiMemoryGame. Remove One?
    func color(for theme: Theme) -> Color {
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
        
}
