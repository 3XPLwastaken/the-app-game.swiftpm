//
//  SwiftUIView.swift
//  the app game
//
//  Created by ADDISON KENEFICK on 12/10/25.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    @Environment(\.modelContext) var context
    @Query var scores: [HighScoreStats]
    
    var body: some View {
        VStack{
            Text("Statistics")
                .font(.largeTitle)
                .bold()
                .padding()
            Spacer()
            Text("High Scores:")
                
            List{
                ForEach(scores){score in
                    HStack{
                        Text("\(score.userName)")
                        Spacer()
                        Text("\(score.userLevel):")
                        Text("\(score.userScore)")


                    }
                }
            
            }
            
        }
    }
}

#Preview {
    StatsView()
}
