//
//  File.swift
//  the app game
//
//  Created by DANIEL ARGHAVANI BADRABAD on 12/9/25.
//

import SwiftUI


struct GameInfo {
    var currentSelected: Int
    var currentStreak = 0
    var pattern: [Int] = []
    var rows = 2

    mutating func generateNext() {
        pattern.append(
            Int.random(in: 0..<(rows * rows))
        )
    }

    func animateEvents() {
        Task {
            for _ in 0..<pattern.count {
                do {
                    try await Task.sleep(nanoseconds: 3_000) // probably 3_000_000_000 in real code
                } catch {
                    // handle error if needed
                }
            }
        }
    }
}
