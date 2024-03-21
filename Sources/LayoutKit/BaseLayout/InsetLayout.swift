import UIKit

struct OffsetLayout: Layout {
    let x: CGFloat
    let y: CGFloat
    
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        subviews.first?.sizeThatFits(size) ?? .zero
    }
    
    func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        subviews.forEach { view in
            let viewSize = view.sizeThatFits(rect.size)
            view.frame = CGRect(
                origin: CGPoint(x: x, y: y),
                size: viewSize
            )
        }
    }
}

public extension UIView {
    func offset(x: CGFloat = .zero, y: CGFloat = .zero) -> UIView {
        OffsetLayout(x: x, y: y) {
            self
        }
    }
}
