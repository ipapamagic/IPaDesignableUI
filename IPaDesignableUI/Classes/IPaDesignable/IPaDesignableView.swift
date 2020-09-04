//
//  IPaDesignableView.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
import IPaImageTool
//@IBDesignable
open class IPaDesignableView: UIView,IPaDesignable,IPaDesignableShadow {
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
    
    @IBInspectable open var shadowColor:UIColor? {
        didSet {
            self.setShadowColor(shadowColor)
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
    @IBInspectable open var shadowBlur: CGFloat {
        get {
            return self.getShadowBlur()
        }
        set {
            self.setShadowBlur(newValue)
        }
    }
    @IBInspectable open var shadowSpread: CGFloat = 0 {
        didSet {
            self.updateShadowPath()
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
    open func setBackgroundImage(_ image:UIImage,mode:UIView.ContentMode) {
        var modifyImage:UIImage
        
        switch mode {
        case .bottom:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:(self.bounds.size.width  - image.size.width) * 0.5   , y: self.bounds.size.height - image.size.height))
                
            }) ?? image
        case.bottomLeft:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:0, y: self.bounds.size.height - image.size.height))
                
            }) ?? image
        case .bottomRight:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:self.bounds.size.width - image.size.width, y: self.bounds.size.height - image.size.height))
                
            }) ?? image
        case .center:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:(self.bounds.size.width  - image.size.width) * 0.5   , y: (self.bounds.size.height - image.size.height) * 0.5))
                
            }) ?? image
        case .left:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:self.bounds.size.width - image.size.width    , y: (self.bounds.size.height - image.size.height) * 0.5))
                
            }) ?? image
        case .right:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:0 , y: (self.bounds.size.height - image.size.height) * 0.5))
                
            }) ?? image
        case .redraw:
            modifyImage = image
        case .scaleAspectFill:
            modifyImage = image.image(aspectFillSize:self.bounds.size)
        case .scaleAspectFit:
            modifyImage = image.image(fitSize:self.bounds.size)
        case .scaleToFill:
            modifyImage = image.image(size: self.bounds.size)
        case .top:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:(self.bounds.size.width - image.size.width) * 0.5  , y: 0))
                
            }) ?? image
        case .topRight:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:self.bounds.size.width - image.size.width  , y: 0))
                
            }) ?? image
        case .topLeft:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:0  , y: 0))
                
            }) ?? image
        @unknown default:
            modifyImage = image
        }
        
        

        self.backgroundColor = UIColor(patternImage: modifyImage)
            
    }
}
