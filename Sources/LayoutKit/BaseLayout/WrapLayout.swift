import UIKit

public struct WrapLayout: Layout {
    let view: UIView
    public init(_ view: UIView) {
        self.view = view
    }
    public func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        view.sizeThatFits(size)
    }
    
    public func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        subviews.forEach {
            $0.frame = rect
        }
    }
}
