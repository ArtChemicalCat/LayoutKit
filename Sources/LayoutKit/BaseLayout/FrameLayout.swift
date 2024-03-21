import UIKit

struct FrameLayout: Layout {
    let width: CGFloat?
    let height: CGFloat?
    let minWidth: CGFloat?
    let minHeight: CGFloat?
    let maxWidth: CGFloat?
    let maxHeight: CGFloat?
    
    let alignment: Alignment
    
    init(width: CGFloat?, height: CGFloat?, alignment: Alignment) {
        self.width = width
        self.height = height
        self.minWidth = nil
        self.minHeight = nil
        self.maxWidth = nil
        self.maxHeight = nil
        self.alignment = alignment
    }
    
    init(
        minWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: Alignment
    ) {
        self.width = nil
        self.height = nil
        self.minWidth = minWidth
        self.minHeight = minHeight
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.alignment = alignment
    }
    
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        guard let view = subviews.first else { return .zero }
        
        if height != nil || width != nil {
            return view.sizeThatFits(
                CGSize(
                    width: width ?? size.width,
                    height: height ?? size.height
                )
            )
        }
        
        let viewSize = view.sizeThatFits(
            allowedSize(from: size)
        )
        
        return allowedSize(from: viewSize)
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
    
    private func allowedSize(from size: CGSize) -> CGSize {
        CGSize(
            width: max(min(maxWidth ?? .infinity, size.width), minWidth ?? .zero),
            height: max(min(maxHeight ?? .infinity, size.height), minHeight ?? .zero)
        )
    }
}

public extension UIView {
    func frame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> UIView {
        FrameLayout(width: width, height: height, alignment: alignment)(priority: .max) {
            self
        }
    }
    
    func frame(
        minWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> UIView {
        FrameLayout(
            minWidth: minWidth,
            minHeight: minHeight,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            alignment: alignment
        )(priority: .max) {
            self
        }
    }
}
