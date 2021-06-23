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
    @IBInspectable open var shadowSpread: CGFloat = 0{
        didSet {
            self.updateShadowPath()
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
    var ratioConstraintPrority:Float = 250
    @IBInspectable open var imageRatioConstraintPrority:Float {
        get {
            return ratioConstraintPrority
        }
        set {
            ratioConstraintPrority = newValue
        }
    }
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
}
