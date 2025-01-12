import SpriteKit

class GameOverScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        let label = SKLabelNode(text: "Game Over")
        label.fontName = "Arial-BoldMT"
        label.fontSize = 50
        label.fontColor = .white
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
        
        let retryLabel = SKLabelNode(text: "Tap to Retry")
        retryLabel.fontName = "Arial"
        retryLabel.fontSize = 25
        retryLabel.fontColor = .white
        retryLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 - 50)
        addChild(retryLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.fade(withDuration: 1.0)
        let gameScene = GameScene(size: size)
        view?.presentScene(gameScene, transition: transition)
    }
}
