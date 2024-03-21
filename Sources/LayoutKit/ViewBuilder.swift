import UIKit.UIView

@resultBuilder
public struct ViewBuilder {
    public typealias Component = UIView
    
    public static func buildPartialBlock(first: Component) -> [Component] {
        [first]
    }
    
    public static func buildPartialBlock(first: [Component]) -> [Component] {
        first
    }
    
    public static func buildPartialBlock(accumulated: [Component], next: Component) -> [Component] {
        accumulated + [next]
    }
    
    public static func buildPartialBlock(accumulated: [Component], next: [Component]) -> [Component] {
        accumulated + next
    }

    public static func buildExpression(_ expression: Component) -> [Component] {
        [expression]
    }

    public static func buildExpression(_ expression: [Component]) -> [Component] {
        expression
    }
}
