import Foundation

public protocol WithObject: AnyObject {}
extension NSObject: WithObject {}

public extension WithObject {
    func with(_ block: @escaping (Self) -> Void) -> Self {
        block(self)
        return self
    }
    
    func with<Member>(_ keyPath: ReferenceWritableKeyPath<Self, Member>, _ value: Member) -> Self {
        with {
            $0[keyPath: keyPath] = value
        }
    }
}
