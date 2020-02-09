//
//  IPaDesignableImageView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2017/12/28.
//

import UIKit
//@IBDesignable
open class IPaDesignableImageView: UIImageView ,IPaDesignable,IPaDesignableShadow,IPaDesignableFitImage {
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
    open var shadowColor:UIColor? {
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
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var ratioConstraint:NSLayoutConstraint?
    override open var image: UIImage? {
        didSet {
            if let image = image {
                self.computeImageRatioConstraint(image)
                
            }
            else {
                self.removeImageRatioConstraint()
            }
            
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
