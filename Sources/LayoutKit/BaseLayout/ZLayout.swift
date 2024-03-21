import UIKit

protocol ZLayout: Layout {
    var alignment: Alignment { get }
    var sizeTable: Ref<[UIView: CGSize]> { get }
}

extension ZLayout {
    func place(in rect: CGRect) -> (UIView) -> Void {
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

struct BaseZLayout: ZLayout {
    let alignment: Alignment
    let sizeTable = Ref([UIView : CGSize]())
    
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        subviews.forEach { view in
            let viewSize = view.sizeThatFits(size)
            sizeTable.value[view] = viewSize
        }
        
        return subviews.first.flatMap {
            sizeTable.value[$0]
        }  ?? .zero
    }
    
    func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        subviews.forEach(
            place(in: rect)
        )
    }
}

public extension UIView {
    func background(alignment: Alignment = .center, @ViewBuilder views: () -> [UIView]) -> UIView {
        BaseZLayout(alignment: alignment) {
            views()
            self
        }
    }
    
    func overlay(alignment: Alignment = .center, @ViewBuilder views: () -> [UIView]) -> UIView {
        BaseZLayout(alignment: alignment) {
            self
            views()
        }
    }
}
