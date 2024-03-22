import UIKit

public extension UILabel {
    func font(_ font: UIFont) -> Self {
        with(\.font, setTo: font)
    }
    
    func textStyle(_ style: UIFont.TextStyle) -> Self {
        font(.preferredFont(forTextStyle: style))
    }
    
    func textColor(_ color: UIColor) -> Self {
        with(\.textColor, setTo: color)
    }
    
    func textAlignment(_ alignment: NSTextAlignment) -> Self {
        with(\.textAlignment, setTo: alignment)
    }
}
