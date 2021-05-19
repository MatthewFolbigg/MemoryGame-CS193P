//
//  ContentView.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 18/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    var vehicleTheme = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🏍", "🛺", "🚠", "🚃", "🚂", "🚀", "🚁", "🛶", "⛵️", "🚤", "🚲", "🛵"]
    var fruitTheme = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥝"]
    var animalTheme = ["🐶", "🦊", "🐻", "🐼", "🐨", "🐯", "🐮", "🐷"]
    
    @State var emojis: [String] = ["P", "I", "C", "K", "🚀", "🍏", "🐻", "A", "M", "O", "D", "E"]
    @State var numberOfCards = 12
    
    var body: some View {
        VStack{
            Text("Memoji")
                .font(.title)
                .fontWeight(.light)
                .foregroundColor(.primary)
                .padding(.top)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: bestCardWidthFor(numberOfCards: numberOfCards)))]) {
                    ForEach(emojis[0..<emojis.count], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .padding(.horizontal)
            }
            .foregroundColor(.green)
            Spacer()
            HStack(alignment: .bottom, spacing: 10) {
                Spacer()
                themeButton(name: "Vehicles", systemImage: "car", theme: vehicleTheme)
                Spacer()
                themeButton(name: "Fruit", systemImage: "leaf", theme: fruitTheme)
                Spacer()
                themeButton(name: "Animals", systemImage: "hare", theme: animalTheme)
                Spacer()
            }
            .font(.title)
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder func themeButton(name: String, systemImage: String, theme: [String]) -> some View {
        let numberOfCards = Int.random(in: 4..<theme.count)
        Button(action: {
            self.numberOfCards = numberOfCards
            let randomSelectionFromTheme = theme.shuffled().prefix(numberOfCards)
            self.emojis = Array(randomSelectionFromTheme)
        }, label: {
            VStack {
                Image(systemName: systemImage)
                Text(name).font(.caption)
            }
        })
    }
    
    func bestCardWidthFor(numberOfCards: Int) -> CGFloat {
        if numberOfCards <= 4 {
            return 125
        } else if numberOfCards <= 8 {
            return 100
        } else if numberOfCards <= 12 {
            return 75
        } else if numberOfCards <= 24 {
            return 55
        } else {
            return 50
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack() {
            let cardShape = RoundedRectangle(cornerRadius: 15, style: .continuous)
            if isFaceUp {
                cardShape.fill().foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                cardShape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 mini")
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 mini")
    }
}
