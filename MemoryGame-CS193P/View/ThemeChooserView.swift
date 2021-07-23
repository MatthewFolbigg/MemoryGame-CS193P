//
//  ThemeChooserView.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 23/07/2021.
//

import SwiftUI

struct ThemeChooserView: View {
    @ObservedObject var themeChooser: ThemeChooser
    
    
    var body: some View {
        NavigationView {
            List(themeChooser.themes) { theme in
                NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(theme.emoji[0])
                            Text(theme.name)
                            Spacer()
                            Text("\(theme.numberOfPairs)")
                        }
                        .foregroundColor(themeChooser.color(for: theme))
                    }
                }
            }
            .navigationTitle("Themes")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView(themeChooser: ThemeChooser())
    }
}
