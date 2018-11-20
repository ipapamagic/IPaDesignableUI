//
//  IPaDesignableButton.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
//@IBDesignable
open class IPaDesignableButton: UIButton {
    
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
            self.layer.shadowColor = shadowColor?.cgColor
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
    @objc open func centerImageUpTitleDown(_ space:CGFloat) {
        guard let imageView = imageView,let image = imageView.image,let titleLabel = titleLabel,let titleText = titleLabel.text else {
            return
        }
        let imageSize = image.size
        var x = -imageSize.width * 0.5
        var y = (imageSize.height + space) * 0.5
        titleEdgeInsets = UIEdgeInsets(
            top: y, left: x, bottom: -y, right: -x)
        
        // raise the image and push it right so it appears centered
        //  above the text
        let titleSize = titleText.size(withAttributes: [NSAttributedStringKey.font: titleLabel.font])
        x = titleSize.width * 0.5
        y = -(titleSize.height + space) * 0.5
        imageEdgeInsets = UIEdgeInsets(
            top: y, left: x, bottom: -y, right: -x)
        let width = max(imageSize.width,titleSize.width)
        let height = imageSize.height + titleSize.height + space
        x = (width - bounds.width) * 0.5
        y = (height - bounds.height) * 0.5
        contentEdgeInsets = UIEdgeInsets(top: y, left: x, bottom: y, right: x)
    }
    @objc open func imageAlignRight(_ space:CGFloat) {
        guard let imageView = imageView,let titleLabel = titleLabel else {
            return
        }
        let halfSpace = space * 0.5
        let titleLeft = -imageView.frame.size.width - halfSpace
        titleEdgeInsets = UIEdgeInsets(top: 0, left: titleLeft, bottom: 0, right: -titleLeft)
        let imageLeft = titleLabel.frame.size.width + halfSpace
        imageEdgeInsets = UIEdgeInsets(top: 0, left: imageLeft, bottom: 0, right: -imageLeft)
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: halfSpace, bottom: 0, right: halfSpace)
    }
    @objc open func imageAlignRight(textLeftSpace:CGFloat, imageRightSpace:CGFloat,width:CGFloat) {
        guard let imageView = imageView,let titleLabel = titleLabel else {
            return
        }
        let space:CGFloat = (width - imageView.frame.size.width - titleLabel.frame.size.width - textLeftSpace - imageRightSpace)
        let halfSpace = space * 0.5
        let titleLeft = -imageView.frame.size.width - halfSpace
        titleEdgeInsets = UIEdgeInsets(top: 0, left: titleLeft, bottom: 0, right: -titleLeft)
        let imageLeft = titleLabel.frame.size.width + halfSpace
        imageEdgeInsets = UIEdgeInsets(top: 0, left: imageLeft, bottom: 0, right: -imageLeft)
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: halfSpace + textLeftSpace, bottom: 0, right: halfSpace + imageRightSpace)
        
    }
}
