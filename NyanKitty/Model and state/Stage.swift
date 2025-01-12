import SpriteKit

struct Stage {
    static var maxCount: Int {
        var stageNumber = 0
        while SKScene(fileNamed: "Stage\(stageNumber + 1)") != nil {
            stageNumber += 1
        }
        return stageNumber
    }

    static var current: Int {
        get {
            return UserDefaults.standard.integer(forKey: "actualStage")
        }
        set(newStage) {
            UserDefaults.standard.set(newStage, forKey: "actualStage")
            UserDefaults.standard.synchronize()
        }
    }

    static var name: String {
        return "Stage\(current)"
    }

    static func obstacleSpeed(forStage stage: Int) -> TimeInterval {
        return max(3.0 - Double(stage) * 0.5, 1.5)
    }
}
