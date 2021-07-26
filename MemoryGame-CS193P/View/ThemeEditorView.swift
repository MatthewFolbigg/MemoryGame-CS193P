//
//  ThemeEditorView.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 26/07/2021.
//

import SwiftUI

struct ThemeEditorView: View {
    
    @ObservedObject var themeStore: ThemeStore
    @Binding var isDisplayed: Bool
    @Binding var chosenThemeIdex: Int
    @State var emojiToAdd: String = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                themeSection
                cardsSection
                addEmojiSection
                gameplaySection
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isDisplayed = false
                    }
                }
            }
            .navigationTitle("Edit Theme")
        }
    }
    
    var themeSection: some View {
        Section(header: Text("Theme")) {
            TextField("Name", text: $themeStore.themes[chosenThemeIdex].name)
            ColorPicker(selection: $themeStore.themes[chosenThemeIdex].color) {
                Text("Colour")
                    .foregroundColor(themeStore.themes[chosenThemeIdex].color)
            }
        }
    }
    
    var cardsSection: some View {
        Section(header: Text("Cards"), footer: Text("Tap to remove (Minimum of 2 cards)")) {
            let emojis = themeStore.themes[chosenThemeIdex].emoji
            let columns = [
                GridItem(.adaptive(minimum: 40))]
                LazyVGrid(columns: columns, alignment: .center, spacing: 5) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(.system(size: 40))
                            .onTapGesture {
                                if themeStore.themes[chosenThemeIdex].emoji.count > 2 {
                                    themeStore.themes[chosenThemeIdex].emoji.removeAll(where: { $0 == emoji } )
                                } else {
                                    //MARK: Alert the user to add more emoji first
                                }
                            }
                    }
                }
        }
    }
    
    var addEmojiSection: some View {
        Section(header: Text("Add Emoji")) {
            TextField("Add Emoji", text: $emojiToAdd)
                .keyboardType(.default)
                .onChange(of: emojiToAdd, perform: { string in
                    let newEmojis = string.map { String($0) }
                    for emoji in newEmojis {
                        if themeStore.themes[chosenThemeIdex].emoji.contains(emoji) {
                            emojiToAdd = ""
                        } else {
                            themeStore.themes[chosenThemeIdex].emoji.append(emoji)
                            emojiToAdd = ""
                        }
                    }
                })
        }
    }
    
    var gameplaySection: some View {
        Section(header: Text("Gameplay")) {
            Stepper(value: $themeStore.themes[chosenThemeIdex].numberOfPairs, in: 2...themeStore.themes[chosenThemeIdex].emoji.count) {
                Text("Pairs in game: \(themeStore.themes[chosenThemeIdex].numberOfPairs)")
            }
        }
    }
}

struct ThemeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditorView(themeStore: ThemeStore(named: "Default"), isDisplayed: .constant(true), chosenThemeIdex: .constant(0))
            .previewDevice("iPod touch (7th generation)")
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/302.0/*@END_MENU_TOKEN@*/, height: 400))
    }
}
