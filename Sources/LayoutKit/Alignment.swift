public struct Alignment {
    public enum Vertical {
        case left, right, center
    }
    
    public enum Horizontal {
        case top, bottom, center
    }
    
    public let vertical: Vertical
    public let horizontal: Horizontal
    
    public init(
        _ horizontal: Horizontal,
        _ vertical: Vertical
    ) {
        self.vertical = vertical
        self.horizontal = horizontal
    }
    
    public static let topLeft = Alignment(.top, .left)
    public static let topRight = Alignment(.top, .right)
    public static let top = Alignment(.top, .center)
    public static let bottomLeft = Alignment(.bottom, .left)
    public static let bottomRight = Alignment(.bottom, .right)
    public static let bottom = Alignment(.bottom, .center)
    public static let center = Alignment(.center, .center)
    public static let left = Alignment(.center, .left)
    public static let right = Alignment(.center, .right)
}

public enum Axis {
    case vertical
    case horizontal
}
