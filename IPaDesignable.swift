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
    var shadowCornerRadius:CGFloat {get set}
    var shadowColor:UIColor? {get set}
    var shadowRadius:CGFloat {get set}
    var shadowOffset:CGSize {get set}
    var shadowOpacity:CGFloat {get set}
    var shadowPath:CGPath? {get set}
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

extension IPaDesignable where Self:UIView {
    
    func doRoundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        self.cornerMask = CAShapeLayer()
        self.cornerMask?.path = path.cgPath
        layer.mask = self.cornerMask
    }
    
    func setCornerRadius(_ cornerRadius:CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
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
        self.updateShadowCorner()
    }
    func setShadowCornerRadius(_ shadowCornerRadius:CGFloat) {
        self.updateShadowCorner()
    }
    func setShadowRadius(_ shadowRadius: CGFloat) {
        self.layer.shadowRadius = shadowRadius
    }
    func getShadowRadius() -> CGFloat {
        return self.layer.shadowRadius
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
    func setShadowPath(_ shadowPath: CGPath?) {
        self.layer.shadowPath = shadowPath
    }
    func getShadowPath() -> CGPath? {
        return self.layer.shadowPath
    }
    func updateShadowPath() {
        if self.cornerRadius > 0 && self.shadowColor != nil {
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        }
    }
    func updateShadowCorner() {
        if shadowColor != nil {
            self.layer.shadowColor = shadowColor?.cgColor
            self.clipsToBounds = false
            self.layer.masksToBounds = false
            
            if self.shadowCornerRadius > 0 {
                self.layer.shouldRasterize = true
                self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.shadowCornerRadius).cgPath
            }
            self.layer.contentsScale = UIScreen.main.scale
        }
        else {
            self.layer.shadowColor = nil
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
