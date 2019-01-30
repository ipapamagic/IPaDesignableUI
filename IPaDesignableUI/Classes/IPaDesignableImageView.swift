//
//  IPaDesignableImageView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2017/12/28.
//

import UIKit
//@IBDesignable
open class IPaDesignableImageView: UIImageView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    fileprivate var ratioConstraint:NSLayoutConstraint?
    override open var image: UIImage? {
        didSet {
            if let image = image {
                let ratio = image.size.width / image.size.height
                if let ratioConstraint = self.ratioConstraint {
                    if ratioConstraint.multiplier == ratio {
                        return
                    }
                    self.removeConstraint(ratioConstraint)
                    self.ratioConstraint = nil
                }
                let ratioConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: ratio, constant: 0)
                ratioConstraint.priority = UILayoutPriority(rawValue: 800)
                self.addConstraint(ratioConstraint)
                
                self.ratioConstraint = ratioConstraint
                
            }
            else {
                if let ratioConstraint = ratioConstraint {
                    self.removeConstraint(ratioConstraint)
                    self.ratioConstraint = nil
                }
                
            }
            
        }
    }
    override open var bounds: CGRect {
        didSet {
            if self.cornerRadius > 0 && self.shadowColor != nil {
                self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
            }
        }
    }
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
    @IBInspectable open var shadowColor: UIColor? {
        didSet {
            if shadowColor != nil {
                self.layer.shadowColor = shadowColor?.cgColor
                self.clipsToBounds = false
                self.layer.masksToBounds = false
                if self.cornerRadius > 0 {
                    self.layer.shouldRasterize = true
                    self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
                }
                
            }
            else {
                self.layer.shadowColor = nil
            }
            
        }
    }
    @IBInspectable open var shadowRadius: CGFloat {
        set {
            self.layer.shadowRadius = newValue
        }
        get {
            return self.layer.shadowRadius
        }
    }
    @IBInspectable open var shadowOffset: CGSize {
        set {
            self.layer.shadowOffset = newValue
        }
        get {
            return self.layer.shadowOffset
        }
    }
    @IBInspectable open var shadowOpacity: CGFloat {
        set {
            self.layer.shadowOpacity = Float(newValue)
        }
        get {
            return CGFloat(self.layer.shadowOpacity)
        }
    }
    open var shadowPath: CGPath? {
        set {
            self.layer.shadowPath = newValue
        }
        get {
            return self.layer.shadowPath
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
