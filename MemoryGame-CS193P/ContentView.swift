//
//  ContentView.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 18/05/2021.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["💻", "💾", "💿", "📽", "🎞", "🕹", "📼", "📱", "🎚", "📺", "📡", "🔫", "🔌", "💡", "📞", "🎙", "☎️", "🔦", "💣", "🧲", "🔭", "🔬", "🪓", "🔪", "🔩"]
    @State var cardCount = 5
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(emojis[0..<cardCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .padding([.top, .leading, .trailing])
            }.padding(0)
            .foregroundColor(.green)
            Spacer()
            HStack {
                removeCardButton
                Spacer()
                addCardButton
            }
            .font(.title)
            .padding(.horizontal)
        }
        .padding(.horizontal, 1)
    }
    
    var addCardButton: some View {
        Button {
            if cardCount < emojis.count { cardCount += 1 }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    
    var removeCardButton: some View {
        Button {
            if cardCount > 1 { cardCount -= 1 }
        } label: {
            Image(systemName: "minus.circle")
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
