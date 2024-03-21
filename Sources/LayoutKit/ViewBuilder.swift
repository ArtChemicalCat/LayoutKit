import UIKit.UIView

@resultBuilder
public struct ViewBuilder {
    public static func buildPartialBlock<V: UIView>(first: V) -> [V] {
        [first]
    }
    
    public static func buildPartialBlock<V: UIView>(first: [V]) -> [V] {
        first
    }
    
    public static func buildPartialBlock<V: UIView>(accumulated: [V], next: V) -> [V] {
        accumulated + [next]
    }
    
    public static func buildPartialBlock<V: UIView>(accumulated: [V], next: [V]) -> [V] {
        accumulated + next
    }
}
