import UIKit

public struct LayoutPriority: ExpressibleByFloatLiteral {
    let value: Double
    
    init(_ value: Double) {
        self.value = Swift.max(0, Swift.min(1, value))
    }
    
    public init(floatLiteral value: Double) {
        self = .init(value)
    }
    
    static let min: Self = 0.0
    static let max: Self = 1.0
    static let medium: Self = 0.5
    static let low: Self = 0.25
    static let hight: Self = 0.75
}

public protocol WithLayoutPriority {
    var priority: LayoutPriority { get }
}
