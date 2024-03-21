import UIKit

public struct ZStackLayout: ZLayout {
    let alignment: Alignment
    let sizeTable = Ref([UIView: CGSize]())
    
    public init(alignment: Alignment = .center) {
        self.alignment = alignment
    }
    
    public func sizeThatFit(size: CGSize, subviews: [UIView]) -> CGSize {
        var width = CGFloat.zero
        var height = CGFloat.zero
        subviews.forEach { view in
            let viewSize = view.sizeThatFits(size)
            width = max(width, viewSize.width)
            height = max(height, viewSize.height)
            sizeTable.value[view] = viewSize
        }
        
        return CGSize(width: width, height: height)
    }
    
    public func placeSubviews(_ subviews: [UIView], in rect: CGRect) {
        subviews.forEach(
            place(in: rect)
        )
    }
}
