//
//  IPaDesignableLabel.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/28.
//
//

import UIKit
//@IBDesignable
open class IPaDesignableLabel: UILabel {
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
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
    open override func drawText(in rect: CGRect) {
        
        super.drawText(in:UIEdgeInsetsInsetRect(rect,self.textInsets))
    }
    open override var intrinsicContentSize: CGSize
    {
        get {
            var size = super.intrinsicContentSize
            size.width += self.textInsets.left + self.textInsets.right
            size.height += self.textInsets.top + self.textInsets.bottom
            return size
        }
    }
}
