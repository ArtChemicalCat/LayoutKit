import UIKit

struct PaddingLayout: Layout {
    let insets: UIEdgeInsets
    
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        guard let view = subviews.first else { return .zero }
        let size = view.sizeThatFits(
            sizeWithoutPaddings(size)
        )
        
        let height = size.height + insets.top + insets.bottom
        let width = size.width + insets.left + insets.right
        
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        guard let view = subviews.first else { return }
        let size = view.sizeThatFits(
            sizeWithoutPaddings(rect.size)
        )
        
        view.frame = .init(
            origin: CGPoint(
                x: rect.origin.x + insets.left,
                y: rect.origin.y + insets.top
            ),
            size: size
        )
    }
    
    private func sizeWithoutPaddings(_ size: CGSize) -> CGSize {
        CGSize(
            width: size.width - insets.left - insets.right,
            height: size.height - insets.top - insets.bottom
        )
    }
}

public extension UIView {
    func padding(_ insets: UIEdgeInsets) -> UIView {
        PaddingLayout(insets: insets) {
            self
        }
    }
}

public extension UIEdgeInsets {
    static func all(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    static func vertical(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: inset, left: .zero, bottom: inset, right: .zero)
    }
    
    static func horizontal(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: .zero, left: inset, bottom: .zero, right: inset)
    }
    
    static func left(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: .zero, left: inset, bottom: .zero, right: .zero)
    }
    
    static func right(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: inset)
    }
    
    static func top(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: inset, left: .zero, bottom: .zero, right: .zero)
    }
    
    static func bottom(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: .zero, left: .zero, bottom: inset, right: .zero)
    }
    
    func vertical(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: inset, left: left, bottom: inset, right: right)
    }
    
    func horizontal(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: top, left: inset, bottom: bottom, right: inset)
    }
    
    func left(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: top, left: inset, bottom: bottom, right: right)
    }
    
    func right(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: inset)
    }
    
    func top(_ inset: CGFloat) -> Self {
        UIEdgeInsets(top: inset, left: left, bottom: bottom, right: right)
    }
    
    func bottom(_ inset: CGFloat) -> Self {
        print(self)
        return UIEdgeInsets(top: top, left: left, bottom: inset, right: right)
    }
}
