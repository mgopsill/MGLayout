### MGLayout

#### A simple wrapper around Auto Layout for simple programmatic layouts

##### Examples

```swift

// place subview on view an pin all edges i.e. top, bottom, leading, trailing
subview.place(on: view).pin(.allEdges)

// as above with padding
subview.place(on: view).pin(.allEdges(padding: 20))

// as above with no padding and using specific parameters
subview.place(on: view).pin(.top, .leading, .trailing, .bottom)


// if you don't want to chain constraints after placement, simply place first
subview.place(on: view)

// pin top edge to a different views bottom with padding
subview.pin(.top(to: anotherView, .bottom, padding: 10))

// pin horizontal edges to superview
subview.pin(.horizontalEdges)


// pinning top and bottom edges to layout guide and to superview leading and trailing
subview.pin(.top(to: view.safeAreaLayoutGuide), 
            .bottom(to: view.safeAreaLayoutGuide),
            .leading, 
            .trailing)

// pinning fixed height and width in center of superview
subview.pin(.fixedHeight(50), .fixedWidth(50), .centerX, .centerY)
```
