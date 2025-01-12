import SpriteKit

enum AssetIdentifier: String {
    case collectUmbrella, raindropHitCat, raindropHitUmbrella, gameover, crowdCelebrate
}

class Cat: SKSpriteNode {
    private let jumpImpulse = 800
    private let runSpeed: CGFloat = 5
    private var lives: Int = 5
    private let initialSize = CGSize(width: 84, height: 54)
    
    init() {
        let texture = SKTexture(imageNamed: "catStandRight")
        super.init(texture: texture, color: .clear, size: initialSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func jump() {
        physicsBody?.applyImpulse(CGVector(dx: 0, dy: jumpImpulse))
    }
    
    func takeDamage() {
        lives -= 1
        run(SKAction.playSoundFileNamed(AssetIdentifier.raindropHitCat.rawValue, waitForCompletion: false))
    }
}
