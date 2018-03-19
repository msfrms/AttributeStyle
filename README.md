# AttributeStyle
Simple wrapper of NSAttributedString
### Use
```swift
let attributedString = "Hello, world".with(style: AttributeStyle()
                .font(.boldSystemFont(ofSize: 14))
                .color(.foreground(.black))
                .color(.background(.white))
                .color(.underline(.brown))
                .style(.underline(.patternSolid))
                .alignment(.center))
```
