import UIKit

public protocol Layout {
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize
    func placeSubviews(_ subviews: [UIView], in rect: CGRect)
}

extension Layout {
    func callAsFunction(@ViewBuilder _ content: () -> [UIView]) -> UIView {
        let layoutView = LayoutView(self)
        content().forEach(
            layoutView.addSubview
        )
        return layoutView
    }
}
