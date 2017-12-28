//
//  IPaDesignableTextField.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
@IBDesignable
open class IPaDesignableTextField: UITextField {
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
    
    @IBInspectable var textInsets: UIEdgeInsets = UIEdgeInsets.zero
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textInsets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    override open func placeholderRect(forBounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
