import UIKit

public protocol Assignable: AnyObject {}
extension NSObject: Assignable {}

public extension Assignable {
    func assign(to property: inout Self?) -> Self {
        property = self
        return self
    }
    
    func store(in views: inout Set<Self>) -> Self where Self: Hashable {
        views.insert(self)
        return self
    }
}
