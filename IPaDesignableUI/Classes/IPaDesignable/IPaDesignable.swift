//
//  IPaDesignable.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2020/2/9.
//

import UIKit
import IPaUIKitHelper
extension UIView {
    @IBInspectable public var shadowBlur:CGFloat {
        get {
            return self.shadowRadius * 2
        }
        set {
            self.shadowRadius = newValue * 0.5
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




