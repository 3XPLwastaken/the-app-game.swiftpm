
import SwiftUI

@MainActor
class GameInfo {
    var currentStreak = 0
    var pattern: [Int]
    var rowsX: Int
    var rowsY: Int
    var currentMemIdx = 0

    init(rowsX: Int = 2, rowsY: Int = 2, pattern: [Int] = []) {
        self.rowsX = rowsX
        self.rowsY = rowsY
        self.pattern = pattern
    }
    
    func generateNext() {
        pattern.append(
            Int.random(in: 0..<(rowsX * rowsY))
        )
    }
    
    func animateEvents(currentSelected: Binding<Int>) {
        Task {
            print("game start")
            
            for i in 0..<pattern.count {
                let value = pattern[i]
                print("step \(i): \(value)")
                
                // highlight tile
                await MainActor.run {
                    withAnimation(.easeIn.speed(3.0)) {
                        currentSelected.wrappedValue = value
                    }
                }
                
                try? await Task.sleep(nanoseconds: 300_000_000) // 0.3s
                
                // turn off highlight
                await MainActor.run {
                    withAnimation(.easeIn.speed(3.0)) {
                        currentSelected.wrappedValue = -1
                    }
                }
                
                try? await Task.sleep(nanoseconds: 300_000_000) // 0.3s
            }
            
            print("game end")
        }
    }
    
    func isCorrect(input : Int, cs: Binding<Int>) -> Bool {
        if (pattern[currentMemIdx] != input) {
            return false
        }
        
        currentMemIdx += 1
        if (pattern.count >= currentMemIdx) {
            currentMemIdx = 0
            generateNext()
            animateEvents(currentSelected: cs)
        }
        
        return true
    }
}
