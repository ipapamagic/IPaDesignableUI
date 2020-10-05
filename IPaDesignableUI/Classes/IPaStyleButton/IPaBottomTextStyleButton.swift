//
//  IPaBottomTextButton.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2018/11/21.
//

import UIKit
public protocol IPaBottomTextStyle:IPaStyleButton {
    var centerSpace: CGFloat {get set}
    
}
public extension IPaBottomTextStyle {
    func assignStyle() {
        guard let imageView = imageView,let titleLabel = titleLabel,let titleText = titleLabel.text else {
            return
        }
        let imageSize = imageView.frame.size
        var y = (imageSize.height + centerSpace) * 0.5
        titleEdgeInsets = UIEdgeInsets(
            top: y, left: -imageSize.width, bottom: -y, right: 0)
        
        // raise the image and push it right so it appears centered
        //  above the text
        let titleSize = titleText.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font as Any])
        y = -(titleSize.height + centerSpace) * 0.5
        imageEdgeInsets = UIEdgeInsets(
            top: y, left: 0, bottom: -y, right: -titleSize.width)
        let width = max(imageSize.width,titleSize.width)
        let height = imageSize.height + titleSize.height + centerSpace
        let x = (width - bounds.width) * 0.5
        y = (height - bounds.height) * 0.5
        contentEdgeInsets = UIEdgeInsets(top: y, left: x, bottom: y, right: x)
    }
}
open class IPaBottomTextStyleButton: IPaStyleButton,IPaBottomTextStyle {
    @IBInspectable open var centerSpace: CGFloat = 0 {
        didSet {
            self.assignStyle()
        }
    }
    open override func reloadStyle() {
        self.assignStyle()
    }
}
