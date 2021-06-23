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
    
    @IBInspectable open var shadowSpread: CGFloat = 0{
        didSet {
            self.updateShadowPath(shadowPath)
        }
    }
    @IBInspectable open var shadowPath:Bool = false {
        didSet {
            self.updateShadowPath(shadowPath)
        }
    }
    override open var bounds: CGRect {
        didSet {
            
            self.updateShadowPath(shadowPath)
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
