//
//  IPaDesignableTableView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/1/3.
//

import UIKit

open class IPaDesignableTableView: UITableView ,IPaDesignable ,IPaDesignableShadow,IPaDesignableCanBeInnerScrollView {
    @IBInspectable open var simultaneouslyOtherGesture: Bool = false
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
   
    override open var intrinsicContentSize: CGSize {
        
        return self.isScrollEnabled ? super.intrinsicContentSize : self.contentSize
    }
    open override func reloadData() {
        super.reloadData()
        if !self.isScrollEnabled {
            self.invalidateIntrinsicContentSize()
        }
    }
    
}
extension IPaDesignableTableView:UIGestureRecognizerDelegate
{
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return simultaneouslyOtherGesture
    }
}
