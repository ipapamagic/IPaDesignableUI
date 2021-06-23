//
//  IPaDesignableScrollView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2020/6/10.
//

import UIKit

open class IPaDesignableScrollView: UIScrollView,IPaDesignable ,IPaDesignableShadow ,IPaDesignableCanBeInnerScrollView {
    @IBInspectable open var simultaneouslyOtherGesture: Bool = false
    public var cornerMask: CAShapeLayer?
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

  
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }    
}
extension IPaDesignableScrollView:UIGestureRecognizerDelegate
{
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return simultaneouslyOtherGesture
    }
}
