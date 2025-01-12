import SwiftUI
import SpriteKit

enum GameConstants {
    // Screen Dimensions
    static let designWidth: CGFloat = 390  // Based on common iPhone dimensions
    static let designHeight: CGFloat = 844

    // Physics Categories
    struct PhysicsCategory {
        static let none: UInt32 = 0
        static let cat: UInt32 = 0b1       // 1
        static let obstacle: UInt32 = 0b10  // 2
        static let collectible: UInt32 = 0b100  // 4
        static let boundary: UInt32 = 0b1000  // 8
    }
    
    // Scoring
    static let baseScorePerSecond = 1
    static let obstaclePassScore = 5
    
    // Game Speed & Difficulty
    static let initialSpeed: CGFloat = 400
    static let maxSpeed: CGFloat = 1000
    static let difficultyMultiplier: CGFloat = 1.1
    static let speedIncreaseInterval: TimeInterval = 15
    
    // Screen Adaptation Methods
    static func adaptedSize(for size: CGSize, to screenSize: CGSize) -> CGSize {
        let scale = min(screenSize.width / designWidth, screenSize.height / designHeight)
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
    
    static func adaptedPosition(for position: CGPoint, to screenSize: CGSize) -> CGPoint {
        let widthScale = screenSize.width / designWidth
        let heightScale = screenSize.height / designHeight
        return CGPoint(x: position.x * widthScale, y: position.y * heightScale)
    }
}
