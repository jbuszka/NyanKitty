import SpriteKit

class GameOverScene: SKScene {
    // MARK: - Properties
    private var score: Int
    private var gameViewController: GameViewController?
    private var btnView: ButtonView?
    
    // MARK: - Initialization
    init(size: CGSize, score: Int, gameViewController: GameViewController? = nil) {
        self.score = score
        self.gameViewController = gameViewController
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Scene Lifecycle
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 4/255, green: 26/255, blue: 59/255, alpha: 1.0)
        setupUI()
        setupButtons(in: view)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Game Over Title
        let titleLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        titleLabel.text = "GAME OVER"
        titleLabel.fontSize = 48
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: size.width/2, y: size.height * 0.8)
        addChild(titleLabel)
        
        // Score Label
        let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height * 0.7)
        addChild(scoreLabel)
        
        // Stage Label
        let stageLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        stageLabel.text = "Stage \(Stage.current)"
        stageLabel.fontSize = 32
        stageLabel.fontColor = .white
        stageLabel.position = CGPoint(x: size.width/2, y: size.height * 0.6)
        addChild(stageLabel)
    }
    
    private func setupButtons(in view: SKView) {
        btnView = ButtonView()
        btnView?.alignCenter(in: view)
        
        if Stage.current < Stage.maxCount {
            btnView?.btnLoadNextStage.isHidden = false
            btnView?.btnReloadStage.isHidden = true
            btnView?.btnReplayGame.isHidden = true
        } else {
            btnView?.btnLoadNextStage.isHidden = true
            btnView?.btnReloadStage.isHidden = true
            btnView?.btnReplayGame.isHidden = false
        }
        
        if let gameVC = self.view?.window?.rootViewController as? GameViewController {
            btnView?.setActions(for: gameVC)
        }
        
        view.addSubviews(btnView?.buttons ?? [])
    }
}
