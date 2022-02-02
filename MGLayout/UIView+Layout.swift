import UIKit

enum Constraint {
    case relative(NSLayoutConstraint.Attribute, CGFloat, to: Anchorable? = nil, NSLayoutConstraint.Attribute? = nil)
    case fixed(NSLayoutConstraint.Attribute, CGFloat)
    case multiple([Constraint])
}

extension Constraint {
    static let top: Constraint = .top()
    static let bottom: Constraint = .bottom()
    static let trailing: Constraint = .trailing()
    static let leading: Constraint = .leading()
    static let width: Constraint = .width()
    static let height: Constraint = .height()
    static let centerX: Constraint = .centerX()
    static let centerY: Constraint = .centerY()
    static let verticalEdges: Constraint = . verticalEdges()
    static let horizontalEdges: Constraint = . horizontalEdges()
    static let allEdges: Constraint = . allEdges()
    
    static func top(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.top, constant, to: anchors)
    }
    static func bottom(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.bottom, -constant, to: anchors)
    }
    static func trailing(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.trailing, -constant, to: anchors)
    }
    static func leading(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.leading, constant, to: anchors)
    }
    
    static func top(to anchors: Anchorable? = nil, _ toAttribute: NSLayoutConstraint.Attribute? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.top, constant, to: anchors, toAttribute)
    }
    static func bottom(to anchors: Anchorable? = nil, _ toAttribute: NSLayoutConstraint.Attribute? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.bottom, -constant, to: anchors, toAttribute)
    }
    static func trailing(to anchors: Anchorable? = nil, _ toAttribute: NSLayoutConstraint.Attribute? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.trailing, -constant, to: anchors, toAttribute)
    }
    static func leading(to anchors: Anchorable? = nil, _ toAttribute: NSLayoutConstraint.Attribute? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.leading, constant, to: anchors, toAttribute)
    }
    
    static func fixedWidth(_ constant: CGFloat) -> Constraint {
        .fixed(.width, constant)
    }
    static func width(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.width, constant, to: anchors)
    }
    static func fixedHeight(_ constant: CGFloat) -> Constraint {
        .fixed(.height, constant)
    }
    static func height(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.height, constant, to: anchors)
    }
    static func centerX(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.centerX, constant, to: anchors)
    }
    static func centerY(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .relative(.centerY, constant, to: anchors)
    }
    
    static func verticalEdges(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .multiple([.top(to: anchors, constant), .bottom(to: anchors, constant)])
    }
    static func horizontalEdges(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .multiple([.leading(to: anchors, constant), .trailing(to: anchors, constant)])
    }
    static func allEdges(to anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .multiple([.horizontalEdges(to: anchors, constant), .verticalEdges(to: anchors, constant)])
    }
}

extension NSLayoutConstraint {
    convenience init(item: Any, attribute: Attribute, toItem: Any? = nil, toAttribute: Attribute = .notAnAttribute, constant: CGFloat) {
        self.init(item: item,
                  attribute: attribute,
                  relatedBy: .equal,
                  toItem: toItem,
                  attribute: toAttribute,
                  multiplier: 1,
                  constant: constant)
    }
}

extension UIView {
    @discardableResult
    func place(on view: UIView) -> UIView {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func pin(_ constraints: Constraint...) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        apply(constraints)
        return self
    }
    
    private func apply(_ constraints: [Constraint]) {
        for constraint in constraints {
            switch constraint {
            case .relative(let attribute, let constant, let toItem, let toAttribute):
                NSLayoutConstraint(item: self,
                                   attribute: attribute,
                                   toItem: toItem ?? self.superview!,
                                   toAttribute: toAttribute ?? attribute,
                                   constant: constant).isActive = true
            case .fixed(let attribute, let constant):
                NSLayoutConstraint(item: self,
                                   attribute: attribute,
                                   constant: constant).isActive = true
            case .multiple(let constraints):
                apply(constraints)
            }
        }
    }
}

protocol Anchorable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: Anchorable { }
extension UILayoutGuide: Anchorable {
    var firstBaselineAnchor: NSLayoutYAxisAnchor {
        preconditionFailure("UILayoutGuide does not support firstBaselineAnchor")
    }
    
    var lastBaselineAnchor: NSLayoutYAxisAnchor {
        preconditionFailure("UILayoutGuide does not support firstBaselineAnchor")
    }
}
