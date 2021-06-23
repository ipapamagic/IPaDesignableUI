//
//  IPaDesignableCollectionView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/1/2.
//

import UIKit

open class IPaDesignableCollectionView: UICollectionView,IPaDesignable,IPaDesignableShadow ,IPaDesignableCanBeInnerScrollView {
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
        
        return self.collectionViewLayout.collectionViewContentSize
    }
    open override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    open func getCellIndexPath(contain view:UIView) -> IndexPath?
    {
        var cell:UIView? = view
        repeat {
            cell = cell?.superview
            if cell == nil {
                return nil
            }
            else if let cell = cell as? UICollectionViewCell,let indexPath = self.indexPath(for: cell) {
                return indexPath
            }
            
        }while true
    }
}
