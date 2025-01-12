import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let cat = SKSpriteNode(imageNamed: "cat")
    var lastUpdateTime: TimeInterval = 0
    var spawnRaindropTime: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        setupScene()
        spawnCat()
    }
    
    func setupScene() {
        backgroundColor = .black
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.categoryBitMask = PhysicsCategory.none
    }
    
    func spawnCat() {
        cat.position = CGPoint(x: size.width / 2, y: cat.size.height * 2)
        cat.physicsBody = SKPhysicsBody(rectangleOf: cat.size)
        cat.physicsBody?.categoryBitMask = PhysicsCategory.cat
        cat.physicsBody?.contactTestBitMask = PhysicsCategory.raindrop | PhysicsCategory.powerUp
        cat.physicsBody?.collisionBitMask = PhysicsCategory.none
        addChild(cat)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }
        let deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        spawnRaindropTime += deltaTime
        if spawnRaindropTime > GameConstraints.raindropSpawnInterval {
            spawnRaindrop()
            spawnRaindropTime = 0
        }
    }
    
    func spawnRaindrop() {
        let raindrop = SKSpriteNode(imageNamed: "raindrop")
        raindrop.position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height)
        raindrop.physicsBody = SKPhysicsBody(rectangleOf: raindrop.size)
        raindrop.physicsBody?.categoryBitMask = PhysicsCategory.raindrop
        raindrop.physicsBody?.contactTestBitMask = PhysicsCategory.cat
        raindrop.physicsBody?.collisionBitMask = PhysicsCategory.none
        raindrop.physicsBody?.affectedByGravity = true
        addChild(raindrop)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if (firstBody.categoryBitMask == PhysicsCategory.cat && secondBody.categoryBitMask == PhysicsCategory.raindrop) ||
            (firstBody.categoryBitMask == PhysicsCategory.raindrop && secondBody.categoryBitMask == PhysicsCategory.cat) {
            handleCollisionWithRaindrop()
        } else if (firstBody.categoryBitMask == PhysicsCategory.cat && secondBody.categoryBitMask == PhysicsCategory.powerUp) ||
                    (firstBody.categoryBitMask == PhysicsCategory.powerUp && secondBody.categoryBitMask == PhysicsCategory.cat) {
            handleCollisionWithPowerUp()
        }
    }
    
    func handleCollisionWithRaindrop() {
        print("Cat hit by a raindrop!")
    }
    
    func handleCollisionWithPowerUp() {
        print("Cat collected a power-up!")
    }
}
