//
//  MemoryGame_CS193PApp.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 18/05/2021.
//

import SwiftUI

@main
struct MemoryGame_CS193PApp: App {
            
    let themeStore = ThemeStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            ThemeChooserView(themeStore: themeStore)
        }
    }
}
