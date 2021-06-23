//
//  IPaDesignable.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2020/2/9.
//

import UIKit

extension UIView {
    @IBInspectable var maskToBounds:Bool {
        get {
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor:UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowColor:UIColor? {
        get {
            if let color = self.layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowRadius:CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    @IBInspectable var shadowBlur:CGFloat {
        get {
            return self.shadowRadius * 2
        }
        set {
            self.shadowRadius = newValue * 0.5
        }
    }
    @IBInspectable var shadowOffset:CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    @IBInspectable var shadowOpacity:Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
}
public protocol IPaDesignable:UIView {
    var cornerMask:CAShapeLayer? {get set}
}
protocol IPaDesignableShadow:UIView {
    var shadowSpread:CGFloat {get set}
}
protocol IPaDesignableTextInset:UIView {
    var bottomInset: CGFloat {get set}
    var leftInset: CGFloat {get set}
    var rightInset: CGFloat {get set}
    var topInset: CGFloat {get set}
}
protocol IPaDesignableFitImage:UIView {
    var ratioConstraintPrority:Float { get set }
    var ratioConstraint:NSLayoutConstraint? {get set}
}
public protocol IPaDesignableCanBeInnerScrollView:UIGestureRecognizerDelegate  {
    var simultaneouslyOtherGesture:Bool { get set}
    var targetScrollView:UIScrollView {get}
}
extension IPaDesignableCanBeInnerScrollView where Self:UIScrollView{
    public var targetScrollView:UIScrollView {
        get {
            return self
        }
    }
}
extension IPaDesignable where Self:UIView {
    
    static func replaceCSSPtToPx(with string:String) -> String {
        guard let regex = try? NSRegularExpression(pattern: "(\\d+)pt", options:  NSRegularExpression.Options()) else {
            return string
        }
        let newString = regex.stringByReplacingMatches(in: string, options: [], range: NSRange(string.startIndex..., in:string), withTemplate: "$1px")
        
        
        return newString
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        self.cornerMask = CAShapeLayer()
        self.cornerMask?.path = path.cgPath
        layer.mask = self.cornerMask
    }
    
    @discardableResult
    public func applyGradient(colours: [UIColor],startPoint:CGPoint,endPoint:CGPoint,locations: [NSNumber]? = nil) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
}
extension IPaDesignableShadow where Self:IPaDesignable {
    
    
    
    func updateShadowPath(_ forcePath:Bool = false) {
        if shadowSpread == 0 && !forcePath {
            self.layer.shadowPath = nil
        }
        else {
            let dx = -shadowSpread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            
            self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
            
            self.layer.contentsScale = UIScreen.main.scale
        }
    }
    
}

extension IPaDesignableFitImage {
    func removeImageRatioConstraint() {
        if let ratioConstraint = ratioConstraint {
            self.removeConstraint(ratioConstraint)
            self.ratioConstraint = nil
        }
    }
    func computeImageRatioConstraint(_ image:UIImage) {
        
        let ratio = image.size.width / image.size.height
        if let ratioConstraint = self.ratioConstraint {
            if ratioConstraint.multiplier == ratio {
                return
            }
            self.removeConstraint(ratioConstraint)
            self.ratioConstraint = nil
        }
        let ratioConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: ratio, constant: 0)
        ratioConstraint.priority = UILayoutPriority(rawValue: self.ratioConstraintPrority)
        self.addConstraint(ratioConstraint)
        
        self.ratioConstraint = ratioConstraint
        
    
    }
}
