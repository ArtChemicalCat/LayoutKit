import UIKit

open class Controller: UIViewController {
    open var body: UIView {
        UIView()
    }
    
    private var isIgnoringSafeArea = false
    
    private var contentView: UIView?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        let contentView = body
        self.contentView = contentView
        view.addSubview(contentView)
    }
    
    open override func viewDidLayoutSubviews() {
        let layoutFrame = isIgnoringSafeArea ? view.bounds : view.safeAreaLayoutGuide.layoutFrame
        let contentViewSize = contentView?.sizeThatFits(
            layoutFrame.size
        )
        contentView?.frame.size = contentViewSize ?? .zero
        contentView?.center = CGPoint(x: layoutFrame.midX, y: layoutFrame.midY)
    }
    
    public func ignoreSafeArea() {
        self.isIgnoringSafeArea = true
    }
}
