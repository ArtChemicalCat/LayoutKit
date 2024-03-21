import UIKit

struct FillLayout: Layout {
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        size
    }
    
    func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        subviews.first?.frame = rect
    }
}
