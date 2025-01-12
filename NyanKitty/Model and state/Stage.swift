import SpriteKit

class Stage {
    var obstacles: [SKSpriteNode] = []
    var powerUps: [PowerUp] = []
    
    func generateObstacles(for scene: SKScene) {
        for _ in 0..<5 {
            let obstacle = SKSpriteNode(imageNamed: "obstacle")
            obstacle.size = CGSize(width: 50, height: 50)
            obstacle.position = CGPoint(x: CGFloat.random(in: 50...scene.size.width - 50),
                                        y: scene.size.height + 50)
            obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
            obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
            obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.cat
            obstacle.physicsBody?.collisionBitMask = PhysicsCategory.none
            obstacle.physicsBody?.affectedByGravity = false
            obstacles.append(obstacle)
            scene.addChild(obstacle)
        }
    }
    
    func generatePowerUps(for scene: SKScene) {
        let powerUpTypes: [PowerUp.PowerUpType] = [.slowDown, .invincibility]
        for type in powerUpTypes {
            let powerUp = PowerUp(type: type,
                                  position: CGPoint(x: CGFloat.random(in: 50...scene.size.width - 50),
                                                    y: scene.size.height + 100))
            powerUps.append(powerUp)
            scene.addChild(powerUp)
        }
    }
}
