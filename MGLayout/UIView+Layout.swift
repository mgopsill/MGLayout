import UIKit

extension UIView {
    @discardableResult
    func place(on view: UIView) -> UIView {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func pin(_ constraints: Constraint...) -> UIView {
        pin(constraints)
        return self
    }
    
    @discardableResult
    func pin(_ constraints: [Constraint]) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        constraints.forEach { $0.pin(subview: self) }
        return self
    }
}

enum Constraint {
    case top(to: NSLayoutYAxisAnchor? = nil, CGFloat = 0)
    case bottom(to: NSLayoutYAxisAnchor? = nil, CGFloat = 0)
    case trailing(to: NSLayoutXAxisAnchor? = nil, CGFloat = 0)
    case leading(to: NSLayoutXAxisAnchor? = nil, CGFloat = 0)
    case verticalEdges(to: Anchorable? = nil, CGFloat = 0)
    case horizontalEdges(to: Anchorable? = nil, CGFloat = 0)
    case fixedWidth(CGFloat)
    case width(to: Anchorable? = nil, CGFloat = 0)
    case fixedHeight(CGFloat)
    case height(to: Anchorable? = nil, CGFloat = 0)
    case centerX(to: Anchorable? = nil, CGFloat = 0)
    case centerY(to: Anchorable? = nil, CGFloat = 0)
    case allEdges(CGFloat)
    
    static let top: Constraint = .top(0)
    static let bottom: Constraint = .bottom(0)
    static let trailing: Constraint = .trailing(0)
    static let leading: Constraint = .leading(0)
    static let height: Constraint = .height(0)
    static let width: Constraint = .width(0)
    static let centerX: Constraint = .centerX(0)
    static let centerY: Constraint = .centerY(0)
    static let verticalEdges: Constraint = .verticalEdges(0)
    static let horizontalEdges: Constraint = .horizontalEdges(0)
    static let allEdges: Constraint = .allEdges(0)
    
    static func top(to anchors: Anchorable, _ constant: CGFloat = 0) -> Constraint {
        .top(to: anchors.topAnchor, constant)
    }
    static func top(_ anchor: NSLayoutYAxisAnchor? = nil, _ constant: CGFloat = 0) -> Constraint {
        .top(to: anchor, constant)
    }
    static func bottom(_ anchor: NSLayoutYAxisAnchor? = nil, _ constant: CGFloat = 0) -> Constraint {
        .bottom(to: anchor, constant)
    }
    static func bottom(to anchors: Anchorable, _ constant: CGFloat = 0) -> Constraint {
        .bottom(to: anchors.bottomAnchor, constant)
    }
    static func trailing(to anchors: Anchorable, _ constant: CGFloat = 0) -> Constraint {
        .trailing(to: anchors.trailingAnchor, constant)
    }
    static func trailing(_ anchor: NSLayoutXAxisAnchor? = nil, _ constant: CGFloat = 0) -> Constraint {
        .trailing(to: anchor, constant)
    }
    static func leading(to anchors: Anchorable, _ constant: CGFloat = 0) -> Constraint {
        .leading(to: anchors.leadingAnchor, constant)
    }
    static func leading(_ anchor: NSLayoutXAxisAnchor? = nil, _ constant: CGFloat = 0) -> Constraint {
        .leading(to: anchor, constant)
    }
    static func verticalEdges(_ anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .verticalEdges(to: anchors, constant)
    }
    static func horizontalEdges(_ anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .horizontalEdges(to: anchors, constant)
    }
    static func width(_ anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .width(to: anchors, constant)
    }
    static func height(_ anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .height(to: anchors, constant)
    }
    static func centerX(_ anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .centerX(to: anchors, constant)
    }
    static func centerY(_ anchors: Anchorable? = nil, _ constant: CGFloat = 0) -> Constraint {
        .centerY(to: anchors, constant)
    }

    func pin(subview: UIView) {
        switch self {
        case .top(let anchor, let constant):
            let anchor = anchor ?? subview.superview!.topAnchor
            subview.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .bottom(let anchor, let constant):
            let anchor = anchor ?? subview.superview!.bottomAnchor
            subview.bottomAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
        case .trailing(let anchor, let constant):
            let anchor = anchor ?? subview.superview!.trailingAnchor
            subview.trailingAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
        case .leading(let anchor, let constant):
            let anchor = anchor ?? subview.superview!.leadingAnchor
            subview.leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .fixedWidth(let constant):
            subview.widthAnchor.constraint(equalToConstant: constant).isActive = true
        case .width(let anchors, let constant):
            let parent = anchors ?? subview.superview!
            subview.widthAnchor.constraint(equalTo: parent.widthAnchor, constant: constant).isActive = true
        case .fixedHeight(let constant):
            subview.heightAnchor.constraint(equalToConstant: constant).isActive = true
        case .height(let anchors, let constant):
            let parent = anchors ?? subview.superview!
            subview.heightAnchor.constraint(equalTo: parent.heightAnchor, constant: constant).isActive = true
        case .centerX(let anchors, let constant):
            let parent = anchors ?? subview.superview!
            subview.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: constant).isActive = true
        case .centerY(let anchors, let constant):
            let parent = anchors ?? subview.superview!
            subview.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: constant).isActive = true
        case .verticalEdges(let anchors, let constant):
            let anchors = anchors ?? subview.superview!
            let constraints: [Constraint] = [.top(to: anchors, constant), .bottom(to: anchors, constant)]
            constraints.forEach { $0.pin(subview: subview) }
        case .horizontalEdges(let anchors, let constant):
            let anchors = anchors ?? subview.superview!
            let constraints: [Constraint] = [.leading(to: anchors, constant), .trailing(to: anchors, constant)]
            constraints.forEach { $0.pin(subview: subview) }
        case .allEdges(let constant):
            let constraints: [Constraint] = [.horizontalEdges(to: subview.superview!, constant),
                                             .verticalEdges(to: subview.superview!, constant)]
            constraints.forEach { $0.pin(subview: subview) }
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
