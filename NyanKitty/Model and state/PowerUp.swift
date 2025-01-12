import SpriteKit

enum PowerUpType {
    case slowDown
    case invincibility
}

class PowerUp: SKSpriteNode {
    var type: PowerUpType

    init(type: PowerUpType, texture: SKTexture) {
        self.type = type
        super.init(texture: texture, color: .clear, size: texture.size())
        self.name = "powerUp"
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.powerUp
        self.physicsBody?.contactTestBitMask = PhysicsCategory.cat
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.physicsBody?.affectedByGravity = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
