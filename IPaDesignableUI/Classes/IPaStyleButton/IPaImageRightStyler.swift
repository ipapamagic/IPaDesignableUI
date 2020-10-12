//
//  IPaImageRightStyler.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2018/11/22.
//

import UIKit
open class IPaImageRightStyler:IPaButtonStyler {
    @IBInspectable open var centerSpace: CGFloat = 0
    @IBInspectable open var leftSpace: CGFloat = 0
    @IBInspectable open var rightSpace: CGFloat = 0
    open override func reloadStyle(_ button:UIButton) {
        guard let imageView = button.imageView,let titleLabel = button.titleLabel else {
            return
        }
        let space = (centerSpace <= 0) ? (button.bounds.width - leftSpace - rightSpace - imageView.bounds.width - titleLabel.bounds.width) : centerSpace
        
        let halfSpace = space * 0.5
        let titleLeft = -imageView.frame.size.width - halfSpace
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: titleLeft, bottom: 0, right: -titleLeft)
        let imageLeft = titleLabel.frame.size.width + halfSpace
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: imageLeft, bottom: 0, right: -imageLeft)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: halfSpace + leftSpace, bottom: 0, right: halfSpace + rightSpace)
    }
}
