
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
    
    func animateEvents(currentSelected: Binding<Int>, db: Binding<Bool>, lost: Binding<Bool>) {
        Task {
            db.wrappedValue = true
            
            try? await Task.sleep(nanoseconds: 700_000_000)
            
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
            db.wrappedValue = false
        }
    }
    
    func isCorrect(input : Int, cs: Binding<Int>, db: Binding<Bool>, lost: Binding<Bool>) -> Bool {
        
        if (pattern[currentMemIdx] != input) {
            lost.wrappedValue = true
            return false
        }
        
        currentMemIdx += 1
        if (currentMemIdx >= pattern.count) {
            currentMemIdx = 0
            generateNext()
            animateEvents(currentSelected: cs, db: db, lost: lost)
        }
        
        return true
    }
}
