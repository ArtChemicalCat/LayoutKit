import UIKit

extension UIView {
    func controllerRootView() -> UIView? {
        if self.next is UIViewController {
            return self
        }
        self.setNeedsLayout()
        return superview?.controllerRootView()
    }
    
    public func remakeLayout(animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.3, delay: .zero, usingSpringWithDamping: 1, initialSpringVelocity: 0.85) {
                self.controllerRootView()?.setNeedsLayout()
                self.controllerRootView()?.layoutIfNeeded()
            }
        } else {
            controllerRootView()?.setNeedsLayout()
            controllerRootView()?.layoutIfNeeded()
        }
    }
    
    public func clipped(_ clipped: Bool = true) -> Self {
        clipsToBounds = clipped
        return self

    }
}

extension Array<UIView> {
    func visible() -> Self {
        filter { $0.isHidden == false }
    }
}
