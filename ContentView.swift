import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query var scores: [HighScoreStats]
    @State var newHighScore = false
    @State var highScoreName = ""
    
    // pages
    
    @State var goToGame = false
    @State var rowsX = 0
    @State var rowsY = 0
    @State var ModeName = ""
    
    var body: some View{
        
        NavigationStack{
            VStack{
                
                Text("Simon Guesser Game")
                    .font(.largeTitle)
                    .bold()
                    .padding()
             
              
                Spacer()
                Button("Easy"){
                    rowsX = 2
                    rowsY = 1
                    goToGame = true
                    ModeName = "Easy"
                    print("aaaa")
                }
                .frame(width: 165, height: 35)
                .background(.green)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                Button("Medium"){
                    rowsX = 2
                    rowsY = 2
                    ModeName = "Medium"
                    goToGame = true
                }
                .frame(width: 165, height: 35)
                .background(.yellow)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                Button("Hard"){
                    rowsX = 3
                    rowsY = 3
                    ModeName = "Hard"
                    goToGame = true
                }
                .frame(width: 165, height: 35)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                Button("IMPOSSIBLE."){
                    rowsX = 50
                    rowsY = 50
                    goToGame = true
                }
                .frame(width: 300, height: 60)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                .overlay {
                    Image("ez_mode")
                        .resizable()
                        .frame(width: 50, height: 45)
                        .position(x: 60, y: 45)
                }
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
                Button("Save") {
                    
                }
            }
            .navigationDestination(isPresented: $goToGame) {
                GameView(
                    rowsX: rowsX,
                    modeName: ModeName,
                    rowsY: rowsY,
                    gameOpen: $goToGame
                )
            }
        }
        
    }
}
