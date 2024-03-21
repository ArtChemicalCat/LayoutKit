import UIKit

public struct HStackLayout: Layout {
    let alignment: Alignment.Horizontal
    let spacing: CGFloat
    
    let sizeTable = Ref([UIView: CGSize]())
    
    public init(alignment: Alignment.Horizontal = .center, spacing: CGFloat = 8) {
        self.alignment = alignment
        self.spacing = spacing
    }
    
    public func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        guard subviews.isEmpty == false else { return .zero }
        
        let totalSpacing = CGFloat(subviews.count) * spacing - spacing
        let availableWidth = size.width - totalSpacing
        var usedWidth = CGFloat.zero
        var maxHeight = CGFloat.zero
        
        subviews
            .sorted(by: { $0.layoutPriority > $1.layoutPriority })
            .forEach { view in
                let viewSize = view.sizeThatFits(
                    CGSize(
                        width: availableWidth - usedWidth,
                        height: size.height
                    )
                )
                
                if view is Spacer == false {
                    maxHeight = max(maxHeight, viewSize.height)
                }
                
                sizeTable.value[view] = viewSize
                
                usedWidth += viewSize.width
            }
        
        let spacers = subviews.filter { $0 is Spacer }
        let totalSpacersWidth = spacers.reduce(CGFloat.zero) { $0 + (sizeTable.value[$1]?.width ?? .zero) }
        
        spacers.forEach {
            sizeTable.value[$0]?.width = totalSpacersWidth / CGFloat(spacers.count)
        }
        
        return CGSize(
            width: usedWidth + totalSpacing,
            height: maxHeight
        )
    }
    
    public func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        var xPosition = CGFloat.zero
        
        subviews.forEach { view in
            let viewSize = sizeTable.value[view, default: .zero]
            view.frame = CGRect(
                origin: CGPoint(
                    x: xPosition,
                    y: yPositionForView(ofSize: viewSize, in: rect)
                ),
                size: viewSize
            )
            
            xPosition += viewSize.width + spacing
        }
    }
    
    private func yPositionForView(ofSize size: CGSize, in rect: CGRect) -> CGFloat {
        switch alignment {
        case .top:
            CGFloat.zero
        case .bottom:
            rect.height - size.height
        case .center:
            (rect.height - size.height) / 2
        }
    }
}

public final class Label: UILabel {
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let sizeThatFit = super.sizeThatFits(size)
        return CGSize(
            width: min(sizeThatFit.width, size.width),
            height: min(sizeThatFit.height, size.height)
        )
    }
}
