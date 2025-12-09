//
//  SwiftUIView.swift
//  the app game
//
//  Created by DANIEL ARGHAVANI BADRABAD on 12/9/25.
//

import SwiftUI

struct GameView: View {
    @State var rows = 2
    @State var colors : [Color] = [
        .blue, .red, .yellow, .green, .orange, .gray, .purple, .black, .cyan, .teal, .mint, .teal
    ]
    
    // change ts to the one thats animating
    @State var currentlyAnimating = -1
    
    var body: some View {
        VStack {
            ForEach(0..<rows) { x in
                HStack {
                    ForEach(0..<rows) { y in
                        Rectangle()
                            .foregroundStyle(
                                (colors[(x == 1 ? 0 : x + rows) + y]).mix(
                                    with: .white, by: (currentlyAnimating == ((x == 1 ? 0 : x + rows) + y)) ? 0.3 : 0
                                )
                            )
                            .onTapGesture {
                                print(colors[x + y])
                            }
                    }
                }
            }
        }
    }
    
    func playAnimation() {
        
    }
    
    
    
}

#Preview {
    GameView()
}
