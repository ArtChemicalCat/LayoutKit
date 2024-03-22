# Frame based SwiftUI like layout system

## Features:
* VStackLayout
* HStackLayout
* ZStackLayout
* ScrollView
* Frame
* Padding
* Offset


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

You can declare view hierarchy inline, and, if needed assign some views to property for later use:

```
var label: UILabel!

override var body: UIView {
    UILabel()
        .textStyle(.largeTitle)
        .assigne(to: &label)
}

label.text = "Title"

```
