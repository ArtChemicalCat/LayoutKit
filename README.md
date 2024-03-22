# Frame based SwiftUI like layout system

## Get Started
```
final class MyController: Controller {
    override var body: UIView {
        VStackLayout {
            Label("Hello World!!")
                .textStyle(.headline)
            
            UIImage(image: .init(systemName: "globe")
                .tintColor(.systemPink)
        }
    }
}
```
