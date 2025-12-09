//
//  SwiftUIView.swift
//  the app game
//
//  Created by ADDISON KENEFICK on 12/9/25.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        VStack{
            Text("Simon Guesser Game")
                .font(.largeTitle)
                .bold()
                .padding()
            Spacer()
            Button("Easy"){
                
            }
            .frame(width: 165, height: 35)
            .background(.green)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
            Button("Medium"){
                
            }
            .frame(width: 165, height: 35)
            .background(.yellow)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
            Button("Hard"){
                
            }
            .frame(width: 165, height: 35)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
            Button("Stats", systemImage: "trophy") {
                
            }
            Spacer()
        }
    }
}

#Preview {
    HomePageView()
}
