import UIKit

open class ContainerView: BaseView {
    open var body: UIView {
        UIView()
    }
    
    private var _body: UIView!
    
    override public init() {
        super.init()
        _body = body
        addSubview(_body)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        _body.sizeThatFits(size)
    }
    
    public override func layoutSubviews() {
        WrapLayout(_body).placeSubviews(subviews, in: bounds)
    }
}
