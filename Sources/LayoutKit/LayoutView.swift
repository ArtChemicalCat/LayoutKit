import UIKit

public final class LayoutView<L: Layout>: BaseView, WithLayoutPriority {
    
    public var priority: LayoutPriority
    
    private let layout: L
    
    init(_ layout: L, priority: LayoutPriority = .min) {
        self.layout = layout
        self.priority = priority
        super.init()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout.sizeThatFit(size: size, subviews: subviews)
    }
    
    public override func layoutSubviews() {
        layout.placeSubviews(subviews, in: bounds)
    }
}

public extension UIView {
    func layoutPriority(_ priority: Double) -> UIView {
        LayoutView(WrapLayout(view: self), priority: .init(priority))
            .with {
                $0.addSubview(self)
            }
    }
}

public class BaseView: UIView {
    public init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
