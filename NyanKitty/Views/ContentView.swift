import SwiftUI
import SpriteKit

struct ContentView: View {
    @State private var isGameActive = false
    @State private var showLeaderboard = false
    @State private var showSettings = false
    
    private var scene: SKScene {
        let scene = GameScene()
        scene.size = UIScreen.main.bounds.size
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 4/255, green: 26/255, blue: 59/255)
                .edgesIgnoringSafeArea(.all)
            
            if isGameActive {
                // Game View
                SpriteView(scene: scene)
                    .edgesIgnoringSafeArea(.all)
            } else {
                // Main Menu
                VStack(spacing: 30) {
                    Text("NYANKITTY")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("SPACE RACE")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    
                    Button(action: {
                        isGameActive = true
                    }) {
                        Text("START GAME")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 250, height: 50)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.red, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    
                    Button(action: {
                        showLeaderboard = true
                    }) {
                        Text("LEADERBOARD")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 250, height: 50)
                            .background(
                                Color.gray
                                    .opacity(0.2)
                                    .cornerRadius(25)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    
                    Button(action: {
                        showSettings = true
                    }) {
                        Text("SETTINGS")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 250, height: 50)
                            .background(
                                Color.gray
                                    .opacity(0.2)
                                    .cornerRadius(25)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                }
            }
        }
        .sheet(isPresented: $showLeaderboard) {
            LeaderboardView()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ReturnToMainMenu"))) { _ in
            isGameActive = false
        }
    }
}

// Placeholder Views
struct LeaderboardView: View {
    var body: some View {
        Text("Leaderboard Coming Soon!")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings Coming Soon!")
    }
}
