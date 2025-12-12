import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query var scores: [HighScoreStats]
    @State var newHighScore = false
    @State var highScoreName = ""
    var body: some View{
        
        NavigationStack{
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
                Spacer()
                ZStack{
                    Image("simon")
                        .resizable()
                        .frame(width: 100, height: 100)
                    NavigationLink("🏆") {
                        StatsView()
                    }
                   
                }
            }
            .alert("New High Score", isPresented: $newHighScore) {
                TextField("Name:", text: $highScoreName)
                Button("Save"){
                    
                }
            }
        }
        
    }
}
