import UIKit

open class Controller: UIViewController {
    open var contentView: UIView {
        UIView()
    }
    
    private var _contentView: UIView?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let contentView = contentView
        _contentView = contentView
        view.addSubview(contentView)
    }
    
    open override func viewDidLayoutSubviews() {
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame
        let contentViewSize = _contentView?.sizeThatFits(
            safeAreaFrame.size
        )
        
        _contentView?.frame.size = contentViewSize ?? .zero
        _contentView?.center = CGPoint(x: safeAreaFrame.midX, y: safeAreaFrame.midY)
    }
}
