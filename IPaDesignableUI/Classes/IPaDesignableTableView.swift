//
//  IPaDesignableTableView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/1/3.
//

import UIKit

open class IPaDesignableTableView: UITableView ,IPaDesignable ,IPaDesignableShadow{
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
    open func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.doRoundCorners(corners: corners, radius: radius)
    }
    open func headerViewFitContent() {
        guard let headerView = self.tableHeaderView else {
            return
        }
        let fittingSize = CGSize(width: self.bounds.width , height: 0)
        let size = headerView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        headerView.frame = CGRect(origin: .zero, size: size)
        self.tableHeaderView = headerView
    }
    open func footerViewFitContent() {
        guard let footerView = self.tableFooterView else {
            return
        }
        let fittingSize = CGSize(width: self.bounds.width , height: 0)
        let size = footerView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        footerView.frame = CGRect(origin: .zero, size: size)
        self.tableFooterView = footerView
    }
    open func getCellIndexPath(contain view:UIView) -> IndexPath?
    {
        var cell:UIView? = view
        repeat {
            cell = cell?.superview
            if cell == nil {
                return nil
            }
            else if let cell = cell as? UITableViewCell,let indexPath = self.indexPath(for: cell) {
                return indexPath
            }
            
        }while true
    }
}
