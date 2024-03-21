import Foundation

public protocol WithObject: AnyObject {}
extension NSObject: WithObject {}

public extension WithObject {
    func with(_ block: @escaping (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
