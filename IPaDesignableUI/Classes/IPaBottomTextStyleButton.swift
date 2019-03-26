//
//  IPaBottomTextButton.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2018/11/21.
//

import UIKit

open class IPaBottomTextStyleButton: IPaStyleButton {
    @IBInspectable open var centerSpace: CGFloat = 0 {
        didSet {
            self.reloadStyle()
        }
    }
    override func reloadStyle() {
        guard let imageView = imageView,let image = imageView.image,let titleLabel = titleLabel,let titleText = titleLabel.text else {
            return
        }
        let imageSize = image.size
        var x = -imageSize.width * 0.5
        var y = (imageSize.height + centerSpace) * 0.5
        titleEdgeInsets = UIEdgeInsets(
            top: y, left: x, bottom: -y, right: -x)
        
        // raise the image and push it right so it appears centered
        //  above the text
        let titleSize = titleText.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font as Any])
        x = titleSize.width * 0.5
        y = -(titleSize.height + centerSpace) * 0.5
        imageEdgeInsets = UIEdgeInsets(
            top: y, left: x, bottom: -y, right: -x)
        let width = max(imageSize.width,titleSize.width)
        let height = imageSize.height + titleSize.height + centerSpace
        x = (width - bounds.width) * 0.5
        y = (height - bounds.height) * 0.5
        contentEdgeInsets = UIEdgeInsets(top: y, left: x, bottom: y, right: x)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   
}
