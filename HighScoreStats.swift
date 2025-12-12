//
//  File 2.swift
//  the app game
//
//  Created by ADDISON KENEFICK on 12/10/25.
//

import SwiftData
@Model
class HighScoreStats{
    var userName: String
    var userScore: Int
    var userLevel: String
    init(name: String, score: Int, level: String) {
        self.userName = name
        self.userScore = score
        self.userLevel = level
    }
}
