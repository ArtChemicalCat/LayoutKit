import UIKit

final class LayoutView<L: Layout>: BaseView {
    private let layout: L
    
    init(_ layout: L) {
        self.layout = layout
        super.init()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout.sizeThatFit(size: size, subviews: subviews)
    }
    
    override func layoutSubviews() {
        layout.placeSubviews(subviews, in: bounds)
    }
}

class BaseView: UIView {
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
