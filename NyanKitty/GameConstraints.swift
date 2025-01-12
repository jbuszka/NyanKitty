import CoreGraphics

enum GameConstraints {
    static let designWidth: CGFloat = 390
    static let designHeight: CGFloat = 844
    
    static func adaptedSize(for size: CGSize, to screenSize: CGSize) -> CGSize {
        let scale = min(screenSize.width / designWidth, screenSize.height / designHeight)
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
}
