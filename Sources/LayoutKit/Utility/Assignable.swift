import UIKit

public protocol Assignable {}
extension UIView: Assignable {}
public extension Assignable where Self: UIView {
    func assign(to property: inout Self?) -> Self {
        property = self
        return self
    }
    
    func store(in views: inout Set<UIView>) -> Self {
        views.insert(self)
        return self
    }
}

