import UIKit

public protocol WithObject: AnyObject {}

public extension WithObject {
    func with(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
    
    func with<Member>(_ keyPath: ReferenceWritableKeyPath<Self, Member>, setTo value: Member) -> Self {
        with {
            $0[keyPath: keyPath] = value
        }
    }
}

public protocol WithValue {
    @discardableResult
    func with(_ closure: (_ instance: inout Self) -> Void) -> Self
}

public extension WithValue {
    @discardableResult
    func with(_ closure: (_ instance: inout Self) -> Void) -> Self {
        var mutated = self
        closure(&mutated)
        return mutated
    }
}

extension NSObject: WithObject { }
extension JSONDecoder: WithObject { }
extension JSONEncoder: WithObject { }
@available(iOS 13.0, *)
extension NSDiffableDataSourceSnapshot: WithValue {}
