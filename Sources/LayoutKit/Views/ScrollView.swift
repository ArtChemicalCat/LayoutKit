import UIKit
import Combine

public final class ScrollView: UIScrollView {
    public enum Axis {
        case vertical
        case horizontal
    }
    
    let axis: Axis
    let contentView: UIView
    
    private var subscriptions = Set<AnyCancellable>()
    
    public init(
        _ axis: Axis = .vertical,
        alignment: Alignment = .center,
        spacing: CGFloat = 8,
        @ViewBuilder contentView: () -> [UIView]
    ) {
        switch axis {
        case .vertical:
            self.contentView = VStackLayout(alignment: alignment.vertical, spacing: spacing)(contentView)
        case .horizontal:
            self.contentView = HStackLayout(alignment: alignment.horizontal, spacing: spacing)(contentView)
        }
        self.axis = axis
        super.init(frame: .zero)
        addSubview(self.contentView)
        keyboardDismissMode = .onDrag
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        KeyboardPublisher
            .observeKeyboardFrame()
            .removeDuplicates()
            .sink { [unowned self] frame in
                guard let rootView = controllerRootView() else {
                    return
                }
                
                guard frame.height > 0 else {
                    contentInset.bottom = .zero
                    remakeLayout()
                    return
                }
                
                let converted = convert(self.frame, to: rootView)
                let overlappedHeight = self.frame.height - (frame.origin.y - converted.origin.y)
                contentInset.bottom = overlappedHeight
                remakeLayout()
            }
            .store(in: &subscriptions)
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentSize = contentView.sizeThatFits(
            CGSize(
                width: axis == .vertical ? size.width : .infinity,
                height: axis == .horizontal ? size.height : .infinity
            )
        )
        
        return CGSize(
            width: min(contentSize.width + contentInset.left + contentInset.right, size.width),
            height: min(contentSize.height + contentInset.bottom + contentInset.top, size.height)
        )
    }
    
    public override func layoutSubviews() {
        contentView.frame.size = CGSize(
            width: contentSize.width,
            height: contentSize.height + contentInset.bottom
        )
        contentView.frame.origin = .zero
    }
}

enum KeyboardPublisher {
    private static let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIApplication.keyboardWillShowNotification)
        .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) ?? .zero }
    
    private static let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIApplication.keyboardWillHideNotification)
        .map { _ in CGRect.zero }
    
    static func observeKeyboardFrame() -> some Publisher<CGRect, Never> {
        Publishers.MergeMany(keyboardWillHide, keyboardWillShow)
            .removeDuplicates()
    }
}
