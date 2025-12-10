//
//  SwiftUIView.swift
//  the app game
//
//  Created by DANIEL ARGHAVANI BADRABAD on 12/9/25.
//

import SwiftUI

struct GameView: View {
    @State var rows = 2
    @State var colors: [Color] = [
        .blue, .red, .yellow, .green, .orange, .gray,
        .purple, .black, .cyan, .teal, .mint, .teal
    ]
    
    @State var currentlyAnimating = -1
    
    @State var gameInfo = GameInfo(
        currentSelected: $currentlyAnimating, pattern: []
    )
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { x in
                HStack {
                    ForEach(0..<rows, id: \.self) { y in
                        let index = x * rows + y   // <- no duplicates
                        
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
    }
}


#Preview {
    GameView()
}
