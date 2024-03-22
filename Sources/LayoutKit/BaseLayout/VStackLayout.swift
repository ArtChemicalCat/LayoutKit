import UIKit

public struct VStackLayout: Layout {
    let alignment: Alignment.Vertical
    let spacing: CGFloat
    
    let sizeTable = Ref([UIView: CGSize]())
    
    public init(alignment: Alignment.Vertical = .center, spacing: CGFloat = 8) {
        self.alignment = alignment
        self.spacing = spacing
    }
    
    public func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        guard subviews.isEmpty == false else { return .zero }
        
        let totalSpacing = CGFloat(subviews.count) * spacing - spacing
        let availableHeight = size.height - totalSpacing
        var usedHeight = CGFloat.zero
        var maxWidth = CGFloat.zero
        
        subviews
            .lazy
            .sorted(by: { $0.layoutPriority > $1.layoutPriority })
            .forEach { view in
                let viewSize = view.sizeThatFits(
                    CGSize(
                        width: size.width,
                        height: availableHeight - usedHeight
                    )
                )
                if view is Spacer == false {
                    maxWidth = max(maxWidth, viewSize.width)
                }
                sizeTable.value[view] = viewSize
                
                usedHeight += viewSize.height
            }
        
        let spacers = subviews.filter { $0 is Spacer }
        let totalSpacersHeight = spacers.reduce(CGFloat.zero) { $0 + (sizeTable.value[$1]?.height ?? .zero) }
        
        spacers.forEach {
            sizeTable.value[$0]?.height = totalSpacersHeight / CGFloat(spacers.count)
        }
        
        return CGSize(
            width: maxWidth,
            height: usedHeight + totalSpacing
        )
    }
    
    public func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        var yPosition = CGFloat.zero
        
        subviews.forEach { view in
            let viewSize = sizeTable.value[view, default: .zero]
            view.frame = CGRect(
                origin: CGPoint(
                    x: xPositionForView(ofSize: viewSize, in: rect),
                    y: yPosition
                ),
                size: viewSize
            )
            
            yPosition += viewSize.height + spacing
        }
    }
    
    private func xPositionForView(ofSize size: CGSize, in rect: CGRect) -> CGFloat {
        switch alignment {
        case .left:
            CGFloat.zero
        case .right:
            rect.width - size.width
        case .center:
            (rect.width - size.width) / 2
        }
    }
}

public final class Spacer: BaseView {
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        CGSize(
            width: size.width == .infinity ? .zero : size.width,
            height: size.height == .infinity ? .zero : size.height
        )
    }
}
