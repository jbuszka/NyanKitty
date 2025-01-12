import SpriteKit

class PowerUp: SKSpriteNode {

    // MARK: Properties
    static var timeSinceLastSpawn: TimeInterval = 0
    var initialSize = CGSize(width: 40, height: 40)

    // MARK: Initializers
    init() {
        let texture = SKTexture(imageNamed: "powerUp") // Replace with your power-up image
        super.init(texture: texture, color: .clear, size: initialSize)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Actions
    class func checkSpawn(timeBetweenFrames: TimeInterval, in gameScene: SKScene) {
        // Add time to timer
        timeSinceLastSpawn += timeBetweenFrames

        // Spawn power-ups every 10 seconds (adjust as needed)
        if timeSinceLastSpawn > 10.0 {
            spawnPowerUp(in: gameScene)
            timeSinceLastSpawn = 0
        }
    }

    private class func spawnPowerUp(in gameScene: SKScene) {
        let powerUp = PowerUp()

        // Spawn at a random vertical position, off the right edge of the screen
        powerUp.position = CGPoint(x: gameScene.size.width + powerUp.size.width, y: CGFloat.random(in: 0...gameScene.size.height))

        // Set up physics
        powerUp.physicsBody = SKPhysicsBody(rectangleOf: powerUp.size)
        powerUp.physicsBody?.categoryBitMask = PhysicsCategory.powerUp.rawValue
        powerUp.physicsBody?.contactTestBitMask = PhysicsCategory.cat.rawValue
        powerUp.physicsBody?.collisionBitMask = 0
        powerUp.physicsBody?.affectedByGravity = false
        powerUp.physicsBody?.isDynamic = true

        // Add to the scene
        gameScene.addChild(powerUp)

        // Animate movement from right to left
        let move = SKAction.moveTo(x: -powerUp.size.width, duration: 6.0)
        let remove = SKAction.removeFromParent()
        powerUp.run(SKAction.sequence([move, remove]))
    }

    class func collect(_ powerUp: SKNode, by player: SKNode, in gameScene: SKScene) {
        // Trigger a power-up effect
        print("Power-Up Collected!")

        // Optional: Add a visual effect
        if let effect = SKEmitterNode(fileNamed: "PowerUpEffect") {
            effect.position = powerUp.position
            gameScene.addChild(effect)
        }

        // Remove power-up
        powerUp.removeFromParent()
    }
}
