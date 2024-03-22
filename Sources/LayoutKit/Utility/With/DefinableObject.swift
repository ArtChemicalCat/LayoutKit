import UIKit

public protocol DefinableObject: AnyObject {}

public extension DefinableObject {
    func define(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
    
    func set<Member>(_ keyPath: ReferenceWritableKeyPath<Self, Member>, to value: Member) -> Self {
        define {
            $0[keyPath: keyPath] = value
        }
    }
}

public protocol DefinableValue {
    @discardableResult
    func define(_ closure: (_ instance: inout Self) -> Void) -> Self
}

public extension DefinableValue {
    @discardableResult
    func define(_ closure: (_ instance: inout Self) -> Void) -> Self {
        var mutated = self
        closure(&mutated)
        return mutated
    }
}

extension NSObject: DefinableObject { }
extension JSONDecoder: DefinableObject { }
extension JSONEncoder: DefinableObject { }
@available(iOS 13.0, *)
extension NSDiffableDataSourceSnapshot: DefinableValue {}
