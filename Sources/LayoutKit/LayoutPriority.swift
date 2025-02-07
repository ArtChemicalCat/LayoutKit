import UIKit

public struct LayoutPriority: ExpressibleByFloatLiteral {
    let value: Double
    
    init(_ value: Double) {
        self.value = Swift.max(0, Swift.min(1, value))
    }
    
    public init(floatLiteral value: Double) {
        self = .init(value)
    }
    
    public static let min: Self = 0.0
    public static let max: Self = 1.0
    public static let medium: Self = 0.5
    public static let low: Self = 0.25
    public static let hight: Self = 0.75
}

public protocol WithLayoutPriority {
    var priority: LayoutPriority { get }
}

extension UIView {
    var layoutPriority: Double {
        (self as? WithLayoutPriority)?.priority.value ?? .zero
    }
}

extension UILabel: WithLayoutPriority {
    public var priority: LayoutPriority {
        .hight
    }
}

extension UIImageView: WithLayoutPriority {
    public var priority: LayoutPriority {
        .max
    }
}
