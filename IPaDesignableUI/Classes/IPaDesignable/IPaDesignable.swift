//
//  IPaDesignable.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2020/2/9.
//

import UIKit

protocol IPaDesignable:UIView {
    var cornerMask:CAShapeLayer? {get set}
    var cornerRadius:CGFloat {get set}
    var borderWidth:CGFloat {get set}
    var borderColor:UIColor? {get set}
    
}
protocol IPaDesignableShadow:UIView {
    var shadowColor:UIColor? {get set}
    var shadowBlur:CGFloat {get set}
    var shadowSpread:CGFloat {get set}
    var shadowOffset:CGSize {get set}
    var shadowOpacity:CGFloat {get set}
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
@objc public protocol IPaDesignableCanBeInnerScrollView:UIGestureRecognizerDelegate where Self:UIScrollView {
    var simultaneouslyOtherGesture:Bool { get set}
}
extension IPaDesignable where Self:UIView {
    
    static func replaceCSSPtToPx(with string:String) -> String {
        guard let regex = try? NSRegularExpression(pattern: "(\\d+)pt", options:  NSRegularExpression.Options()) else {
            return string
        }
        let newString = regex.stringByReplacingMatches(in: string, options: [], range: NSRange(string.startIndex..., in:string), withTemplate: "$1px")
        
        
        return newString
    }
    
    func doRoundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        self.cornerMask = CAShapeLayer()
        self.cornerMask?.path = path.cgPath
        layer.mask = self.cornerMask
    }
    
    func setCornerRadius(_ cornerRadius:CGFloat,maskToBounds:Bool = true) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = maskToBounds
    }
    func getCornerRadius() -> CGFloat {
        return self.layer.cornerRadius
    }
    func setBorderWidth(_ borderWidth:CGFloat) {
        self.layer.borderWidth = borderWidth
    }
    func getBorderWidth() -> CGFloat {
        return self.layer.borderWidth
    }
    func setBorderColor(_ borderColor:UIColor?) {
        self.layer.borderColor = borderColor?.cgColor
    }
    func getBorderColor() -> UIColor? {
        if let color = self.layer.borderColor {
            return UIColor(cgColor: color)
        }
        return nil
    }
    
}
extension IPaDesignableShadow where Self:IPaDesignable {
    func setShadowColor(_ shadowColor:UIColor?) {
        self.layer.shadowColor = shadowColor?.cgColor
    }
    func getShadowColor() -> UIColor? {
        if let color = self.layer.shadowColor {
            return UIColor(cgColor: color)
        }
        return nil
    }
    func setShadowOffset(_ shadowOffset: CGSize) {
        self.layer.shadowOffset = shadowOffset
    }
    func getShadowOffset() -> CGSize {
        return self.layer.shadowOffset
    }
    func setShadowOpacity(_ shadowOffset: CGFloat) {
        self.layer.shadowOpacity = Float(shadowOffset)
    }
    func getShadowOpacity() -> CGFloat {
        return CGFloat(self.layer.shadowOpacity)
    }
    
    func setShadowBlur(_ blur:CGFloat) {
        self.layer.shadowRadius = shadowBlur * 0.5 
        
    }
    func getShadowBlur() -> CGFloat {
        return self.layer.shadowRadius * 2
    }
    func updateShadowPath() {
        if shadowSpread == 0 {
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
