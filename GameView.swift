import SwiftUI

struct GameView: View {
    @State private var rows = 2
    @State private var colors: [Color] = [
        .blue, .red, .yellow, .green, .orange, .gray,
        .purple, .black, .cyan, .teal, .mint, .teal
    ]
    
    @State private var currentlyAnimating = -1
    @State private var gameInfo = GameInfo()   // <- class instance stored here
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { x in
                HStack {
                    ForEach(0..<rows, id: \.self) { y in
                        let index = x * rows + y
                        
                        Rectangle()
                            .foregroundStyle(
                                colors[index].mix(
                                    with: .white,
                                    by: currentlyAnimating == index ? 0.3 : 0
                                )
                            )
                            .scaleEffect(
                                currentlyAnimating == index ? 1.1 : 1
                            )
                            .onTapGesture {
                                var isCorrect = gameInfo.isCorrect(input: index, cs: $currentlyAnimating)
                                
                                withAnimation(.easeIn.speed(3.0)) {
                                    currentlyAnimating = index
                                }
                                
                                withAnimation(.easeIn.speed(3.0).delay(0.2)) {
                                    currentlyAnimating = -1
                                }
                            }
                    }
                }
            }
        }
        .onAppear {
            // keep GameInfo in sync with the grid size
            gameInfo.rows = rows
            gameInfo.pattern.removeAll()
            
            // build the pattern
            for _ in 0..<1 {
                gameInfo.generateNext()
            }
            
            print("pattern:", gameInfo.pattern)
            
            // animate using the pattern and binding to currentlyAnimating
            gameInfo.animateEvents(currentSelected: $currentlyAnimating)
        }
    }
}

#Preview {
    GameView()
}
