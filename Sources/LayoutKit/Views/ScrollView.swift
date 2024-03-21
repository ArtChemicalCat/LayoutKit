import UIKit

public final class ScrollView: UIScrollView {
    public enum Axis {
        case vertical
        case horizontal
    }
    
    let axis: Axis
    let contentView: UIView
    
    
    public init(_ axis: Axis = .vertical, alignment: Alignment = .center, spacing: CGFloat = 8, @ViewBuilder contentView: () -> [UIView]) {
        switch axis {
        case .vertical:
            self.contentView = VStackLayout(alignment: alignment.vertical, spacing: spacing)(contentView)
        case .horizontal:
            self.contentView = HStackLayout(alignment: alignment.horizontal, spacing: spacing)(contentView)
        }
        self.axis = axis
        super.init(frame: .zero)
        addSubview(self.contentView)
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        size
    }
    
    public override func layoutSubviews() {
        contentSize = contentView.sizeThatFits(
            CGSize(
                width: axis == .vertical ? bounds.width : .infinity,
                height: axis == .horizontal ? bounds.height : .infinity
            )
        )
        
        contentView.frame.size = contentSize
        contentView.frame.origin = .zero
    }
}
