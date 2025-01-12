import Foundation

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let cat: UInt32 = 0x1 << 0
    static let raindrop: UInt32 = 0x1 << 1
    static let powerUp: UInt32 = 0x1 << 2
}
