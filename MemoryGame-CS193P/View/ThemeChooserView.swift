//
//  ThemeChooserView.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 23/07/2021.
//

import SwiftUI

struct ThemeChooserView: View {
    @ObservedObject var themeStore: ThemeStore
    @State private var editMode: EditMode = .inactive
    
    @State private var themeToEditIndex: Int = 0
    @State private var themeEditorPopover: Bool = false
    
    @State var ActiveGame: EmojiMemoryGame?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(themeStore.themes) { theme in
                    NavigationLink(
                        destination: EmojiMemoryGameView(game: game(for: theme), activeGame: $ActiveGame),
                        label: {
                            HStack {
                                Image(systemName: "pencil.circle.fill")
                                    .imageScale(.large)
                                    .opacity(editMode == .active ? 1 : 0)
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        themeToEditIndex = themeStore.themes.firstIndex(where:  { $0.id == theme.id }) ?? 0
                                        themeEditorPopover = true
                                    }
                                    .frame(width: editMode == .active ? 30 : 0, alignment: .leading)
                                themeView(for: theme)
                            }
                        }
                    )
                }
                .onDelete { indexSet in
                    themeStore.themes.remove(atOffsets: indexSet)
                }
                .onMove { indices, newOffset in
                    themeStore.themes.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .sheet(isPresented: $themeEditorPopover, onDismiss: {
                editMode = .inactive
            }, content: {
                ThemeEditorView(themeStore: themeStore, isDisplayed: $themeEditorPopover, chosenThemeIdex: $themeToEditIndex)
            })
            .navigationTitle("Memorise")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem { EditButton() }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        themeStore.addTheme()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .environment(\.editMode, $editMode)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func themeView(for theme: Theme) -> some View {
        HStack {
            Text(theme.emoji[0])
            Text(theme.name)
                .foregroundColor(theme.color)
            Spacer()
            Text("\(theme.numberOfPairs)")
                .foregroundColor(theme.color)
        }
    }
    
    func game(for theme: Theme) -> EmojiMemoryGame {
        if let game = ActiveGame, game.theme == theme {
            return game
        } else {
            return EmojiMemoryGame(theme: theme)
        }
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView(themeStore: ThemeStore(named: "Default"))
    }
}
