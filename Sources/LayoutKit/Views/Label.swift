import UIKit

public final class Label: UILabel {
    public init(_ text: String = "") {
        super.init(frame: .zero)
        self.text = text
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let sizeThatFit = super.sizeThatFits(size)
        return CGSize(
            width: min(sizeThatFit.width, size.width),
            height: min(sizeThatFit.height, size.height)
        )
    }
}
