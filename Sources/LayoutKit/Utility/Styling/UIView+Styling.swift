import UIKit

public extension UIView {
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    func tintColor(_ color: UIColor) -> Self {
        tintColor = color
        return self
    }
    
    @discardableResult
    func roundedCorners(_ radius: Double, corners: CACornerMask? = nil) -> Self {
        layer.cornerRadius = radius
        corners.map { layer.maskedCorners = $0 }
        return self
    }
}
