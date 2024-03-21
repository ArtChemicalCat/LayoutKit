import UIKit

public protocol Layout {
    func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize
    func placeSubviews(_ subviews: [UIView], in rect: CGRect)
}
