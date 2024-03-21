import UIKit

public protocol Layout {
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize
    func placeSubviews(_ subviews: [UIView], in rect: CGRect)
}

public extension Layout {
    func callAsFunction(@ViewBuilder _ content: () -> [UIView]) -> UIView {
        let layoutView = LayoutView(self)
        content().forEach(
            layoutView.addSubview
        )
        return layoutView
    }
    
    func callAsFunction(priority: LayoutPriority, @ViewBuilder _ content: () -> [UIView]) -> UIView {
        let layoutView = LayoutView(self, priority: priority)
        content().forEach(
            layoutView.addSubview
        )
        return layoutView
    }
}
