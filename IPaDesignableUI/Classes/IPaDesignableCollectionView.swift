//
//  IPaDesignableCollectionView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/1/2.
//

import UIKit

open class IPaDesignableCollectionView: UICollectionView,IPaDesignable,IPaDesignableShadow {
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
    
    override open var intrinsicContentSize: CGSize {
        
        return self.collectionViewLayout.collectionViewContentSize
    }
    open override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    open func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.doRoundCorners(corners: corners, radius: radius)
    }
}
