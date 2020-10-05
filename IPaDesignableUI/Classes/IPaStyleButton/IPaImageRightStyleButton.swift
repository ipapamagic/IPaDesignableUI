//
//  IPaImageRightStyleButton.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2018/11/22.
//

import UIKit
public protocol IPaImageRightStyle:IPaStyleButton {
    var centerSpace: CGFloat {get set}
    var leftSpace: CGFloat {get set}
    var rightSpace: CGFloat {get set}
}
public extension IPaImageRightStyle {
    func assignStyle() {
        guard let imageView = imageView,let titleLabel = titleLabel else {
            return
        }
        var space = centerSpace
        if centerSpace < 0 {
            space = self.bounds.width - leftSpace - rightSpace - imageView.bounds.width - titleLabel.bounds.width
        }
        
        let halfSpace = space * 0.5
        let titleLeft = -imageView.frame.size.width - halfSpace
        titleEdgeInsets = UIEdgeInsets(top: 0, left: titleLeft, bottom: 0, right: -titleLeft)
        let imageLeft = titleLabel.frame.size.width + halfSpace
        imageEdgeInsets = UIEdgeInsets(top: 0, left: imageLeft, bottom: 0, right: -imageLeft)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: halfSpace + leftSpace, bottom: 0, right: halfSpace + rightSpace)
    }
}
open class IPaImageRightStyleButton: IPaStyleButton,IPaImageRightStyle {
    @IBInspectable open var centerSpace: CGFloat = 0 {
        didSet {
            self.assignStyle()
        }
    }
    @IBInspectable open var leftSpace: CGFloat = 0 {
        didSet {
            self.assignStyle()
        }
    }
    @IBInspectable open var rightSpace: CGFloat = 0 {
        didSet {
            self.assignStyle()
        }
    }
    open override func reloadStyle() {
        self.assignStyle()
    }
}
