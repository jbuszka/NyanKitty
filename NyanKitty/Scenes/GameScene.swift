import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var cat: SKSpriteNode!
    private var cam = SKCameraNode()
    private var score = 0

    private let obstacleCategory: UInt32 = 0x1 << 1
    private let powerUpCategory: UInt32 = 0x1 << 2

    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        setupGame()
        startObstacleSpawning()
    }

    private func setupGame() {
        setupCat()
        setupCamera()
        setupBoundaries()
    }

    private func setupCat() {
        cat = SKSpriteNode(imageNamed: "nyanKitty")
        cat.size = CGSize(width: 100, height: 100)
        cat.position = CGPoint(x: frame.midX / 2, y: frame.midY)
        cat.physicsBody = SKPhysicsBody(rectangleOf: cat.size)
        cat.physicsBody?.categoryBitMask = PhysicsCategory.cat.rawValue
        cat.physicsBody?.contactTestBitMask = obstacleCategory | powerUpCategory
        cat.physicsBody?.collisionBitMask = 0
        cat.physicsBody?.affectedByGravity = false
        cat.physicsBody?.isDynamic = true
        addChild(cat)
    }

    private func setupCamera() {
        camera = cam
        cam.position = CGPoint(x: frame.midX, y: frame.midY)
    }

    private func setupBoundaries() {
        let borderBody = SKPhysicsBody(edgeLoopFrom: frame)
        borderBody.categoryBitMask = PhysicsCategory.ground.rawValue
        physicsBody = borderBody
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            cat.position.y = location.y
        }
    }

    // MARK: - Obstacle Spawning
    private func startObstacleSpawning() {
        let spawn = SKAction.run { [weak self] in
            self?.spawnObstacle()
        }
        let delay = SKAction.wait(forDuration: 2.0) // Adjust delay for obstacle frequency
        let sequence = SKAction.sequence([spawn, delay])
        run(SKAction.repeatForever(sequence), withKey: "ObstacleSpawning")
    }

    private func spawnObstacle() {
        let obstacle = SKSpriteNode(imageNamed: "obstacle")
        obstacle.position = CGPoint(x: size.width + obstacle.size.width, y: CGFloat.random(in: 0...size.height))
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = obstacleCategory
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.cat.rawValue
        obstacle.physicsBody?.collisionBitMask = 0
        obstacle.physicsBody?.affectedByGravity = false
        obstacle.physicsBody?.isDynamic = true
        addChild(obstacle)

        let move = SKAction.moveTo(x: -obstacle.size.width, duration: 4.0) // Adjust duration for obstacle speed
        let remove = SKAction.removeFromParent()
        obstacle.run(SKAction.sequence([move, remove]))
    }

    // MARK: - Power-Up Spawning
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - (PowerUp.timeSinceLastSpawn + PowerUp.timeSinceLastSpawn)
        PowerUp.checkSpawn(timeBetweenFrames: deltaTime, in: self)
    }

    // MARK: - Collision Handling
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB

        if firstBody.categoryBitMask == PhysicsCategory.cat.rawValue || secondBody.categoryBitMask == PhysicsCategory.cat.rawValue {
            if firstBody.categoryBitMask == obstacleCategory || secondBody.categoryBitMask == obstacleCategory {
                handleGameOver()
            } else if firstBody.categoryBitMask == powerUpCategory || secondBody.categoryBitMask == powerUpCategory {
                PowerUp.collect(firstBody.node ?? secondBody.node!, by: cat, in: self)
                increaseScore()
            }
        }
    }

    private func handleGameOver() {
        print("Game Over!")
        AudioUtility.shared.playSound(for: .gameOver)

        // Transition to Game Over screen (if implemented)
        // Example:
        let transition = SKTransition.fade(withDuration: 1.0)
        if let gameOverScene = SKScene(fileNamed: "GameOverScene") {
            view?.presentScene(gameOverScene, transition: transition)
        }
    }

    private func increaseScore() {
        score += 10
        print("Score: \(score)")
    }
}a
