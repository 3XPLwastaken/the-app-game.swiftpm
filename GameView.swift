import SwiftUI

struct GameView: View {
    @State public var rowsX = 2
    @State public var rowsY = 2
    @State public var colors: [Color] = [
        .blue, .red, .yellow, .green, .orange, .gray,
        .purple, .black, .cyan, .teal, .mint, .teal
    ]
    
    @State public var currentlyAnimating = -1
    @State public var gameInfo = GameInfo()   // <- class instance stored here
    
    var body: some View {
        VStack(spacing: (rowsX >= 10 ? 0 : 5)) {
            ForEach(0..<rowsX, id: \.self) { x in
                HStack(spacing: (rowsX >= 10 ? 0 : 5)) {
                    ForEach(0..<rowsY, id: \.self) { y in
                        let index = x * rowsX + y
                        
                        Rectangle()
                            .foregroundStyle(
                                (rowsX >= 10 ? .red : colors[index])
                                .mix(
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
            gameInfo.rowsX = rowsX
            gameInfo.rowsY = rowsY
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
