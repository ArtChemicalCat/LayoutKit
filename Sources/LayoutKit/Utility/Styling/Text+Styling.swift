import UIKit

public extension UILabel {
    func font(_ font: UIFont) -> Self {
        set(\.font, to: font)
    }
    
    func textStyle(_ style: UIFont.TextStyle) -> Self {
        font(.preferredFont(forTextStyle: style))
    }
    
    func textColor(_ color: UIColor) -> Self {
        set(\.textColor, to: color)
    }
    
    func textAlignment(_ alignment: NSTextAlignment) -> Self {
        set(\.textAlignment, to: alignment)
    }
}
