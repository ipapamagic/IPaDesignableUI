//
//  IPaDesignableButton.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
//@IBDesignable
open class IPaDesignableButton: UIButton,IPaDesignable,IPaDesignableShadow {
    open var cornerMask:CAShapeLayer?
    @IBInspectable open var cornerRadius:CGFloat {
        get {
            return self.getCornerRadius()
        }
        set {
            self.setCornerRadius(newValue)
        }
    }
    @IBInspectable open var borderWidth:CGFloat {
        get {
            return self.getBorderWidth()
        }
        set {
            self.setBorderWidth(newValue)
        }
    }
    @IBInspectable open var borderColor:UIColor? {
        get {
            return self.getBorderColor()
        }
        set {
            self.setBorderColor(newValue)
        }
    }
    @IBInspectable open var shadowCornerRadius: CGFloat = 0 {
        didSet {
            self.setShadowCornerRadius(shadowCornerRadius)
        }
    }
    @IBInspectable open var shadowColor:UIColor? {
        didSet {
            self.setShadowColor(shadowColor)
        }
    }
    @IBInspectable open var shadowRadius:CGFloat {
        get {
            return self.getShadowRadius()
        }
        set {
            self.setShadowRadius(newValue)
        }
    }
    @IBInspectable open var shadowOffset:CGSize {
        get {
            return self.getShadowOffset()
        }
        set {
            self.setShadowOffset(newValue)
        }
    }
    @IBInspectable open var shadowOpacity:CGFloat {
        get {
            return self.getShadowOpacity()
        }
        set {
            self.setShadowOpacity(newValue)
        }
    }
    open var shadowPath:CGPath? {
        get {
            return self.getShadowPath()
        }
        set {
            self.setShadowPath(newValue)
        }
    }
    override open var bounds: CGRect {
        didSet {
            self.updateShadowPath()
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.doRoundCorners(corners: corners, radius: radius)
    }
}
