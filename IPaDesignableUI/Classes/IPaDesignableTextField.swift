//
//  IPaDesignableTextField.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
//@IBDesignable
open class IPaDesignableTextField: UITextField,IPaDesignable,IPaDesignableShadow,IPaDesignableTextInset {
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
    @IBInspectable public var bottomInset: CGFloat {
        get {
            return textInsets.bottom
        }
        set {
            textInsets.bottom = newValue
        }
    }
    @IBInspectable public var leftInset: CGFloat {
        get {
            return textInsets.left
        }
        set {
            textInsets.left = newValue
        }
    }
    @IBInspectable public var rightInset: CGFloat {
        get {
            return textInsets.right
        }
        set {
            textInsets.right = newValue
        }
    }
    @IBInspectable public var topInset: CGFloat {
        get {
            return textInsets.top
        }
        set {
            textInsets.top = newValue
        }
    }
    
    @IBInspectable public var textInsets: UIEdgeInsets = UIEdgeInsets.zero
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    override open func placeholderRect(forBounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    open func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.doRoundCorners(corners: corners, radius: radius)
    }
}
