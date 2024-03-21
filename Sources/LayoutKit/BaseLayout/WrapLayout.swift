import UIKit

struct WrapLayout: Layout {
    let view: UIView
    
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        view.sizeThatFits(size)
    }
    
    func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        subviews.forEach {
            $0.frame = rect
        }
    }
}
