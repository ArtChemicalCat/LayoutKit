import UIKit

public struct ZStackLayout: Layout {
    let alignment: Alignment
    private let sizeTable = Ref([UIView: CGSize]())
    
    public init(alignment: Alignment = .center) {
        self.alignment = alignment
    }
    
    public func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        var width = CGFloat.zero
        var height = CGFloat.zero
        subviews.forEach { view in
            let viewSize = view.sizeThatFits(size)
            width = max(width, viewSize.width)
            height = max(height, viewSize.height)
            sizeTable.value[view] = viewSize
        }
        
        return CGSize(width: width, height: height)
    }
    
    public func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        subviews.forEach(
            place(in: rect)
        )
    }
    
    private func place(in rect: CGRect) -> (UIView) -> Void {
        return { view in
            let viewSize = sizeTable.value[view] ?? .zero
            
            let x = switch alignment.vertical {
            case .left:
                CGFloat.zero
            case .right:
                rect.width - viewSize.width
            case .center:
                (rect.width - viewSize.width) / 2
            }
            
            let y = switch alignment.horizontal {
            case .top:
                CGFloat.zero
            case .bottom:
                rect.height - viewSize.height
            case .center:
                (rect.height - viewSize.height) / 2
            }
            
            view.frame = CGRect(
                origin: CGPoint(x: x, y: y),
                size: viewSize
            )
        }
    }
}
