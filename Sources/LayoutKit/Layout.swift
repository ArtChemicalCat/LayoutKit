import UIKit

public protocol Layout {
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize
    func placeSubviews(_ subviews: [UIView], in rect: CGRect)
}

extension Layout {
    func callAsFunction(_ content: () -> UIView) -> UIView {
        let layoutView = LayoutView(self)
        layoutView.addSubview(content())
        return layoutView
    }
}
