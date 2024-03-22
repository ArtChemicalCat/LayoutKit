import UIKit

public final class Button: UIControl {
    private let label: UIView
    private let action: () -> Void
    private let layout: WrapLayout
    
    public init(label: () -> UIView, action: @escaping () -> Void) {
        let label = label()
        self.label = label
        self.layout = WrapLayout(label)
        self.action = action
        super.init(frame: .zero)
        self.label.isUserInteractionEnabled = true
        addSubview(label)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        highlight(true)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        highlight(false)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        highlight(false)
        touches.forEach {
            endTracking($0, with: event)
        }
    }
    
    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        guard let touch else {
            return
        }
        
        if label.frame.contains(touch.location(in: self)) {
            action()
        }
    }
    
    private func highlight(_ isHighlighted: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.label.alpha = isHighlighted ? 0.6 : 1
        }
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        label.sizeThatFits(size)
    }
    
    public override func layoutSubviews() {
        layout.placeSubviews([label], in: bounds)
    }
    
    @objc
    private func handleAction() {
        action()
    }
}
