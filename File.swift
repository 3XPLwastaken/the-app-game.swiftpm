
import SwiftUI

@MainActor
class GameInfo {
    var currentStreak = 0
    var pattern: [Int]
    var rows: Int
    var currentMemIdx = 0

    init(rows: Int = 2, pattern: [Int] = []) {
        self.rows = rows
        self.pattern = pattern
    }
    
    func generateNext() {
        pattern.append(
            Int.random(in: 0..<(rows * rows))
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
