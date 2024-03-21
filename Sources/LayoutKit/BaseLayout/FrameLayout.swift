import UIKit

struct FrameLayout: Layout {
    let width: CGFloat?
    let height: CGFloat?
    let alignment: Alignment
    
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        guard let view = subviews.first else { return .zero }
        let size = view.sizeThatFits(size)
        let height = height ?? size.height
        let width = width ?? size.width
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        guard let view = subviews.first else { return }
        let size = view.sizeThatFits(rect.size)
        
        let x: CGFloat = switch alignment.vertical {
        case .center:
            (rect.width - size.width) / 2
        case .left:
            0
        case .right:
            rect.width - size.width
        }
        
        let y: CGFloat = switch alignment.horizontal {
        case .center:
            (rect.height - size.height) / 2
        case .top:
            0
        case .bottom:
            rect.height - size.height
        }
        
        view.frame = CGRect(
            origin: CGPoint(x: x, y: y),
            size: size
        )
    }
}

public extension UIView {
    func frame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> UIView {
        FrameLayout(width: width, height: height, alignment: alignment) {
            self
        }
    }
}
