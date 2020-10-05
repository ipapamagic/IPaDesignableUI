//
//  IPaStyleButton.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2018/11/22.
//

import UIKit
public protocol IPaStyle:IPaDesignableButton {
    func clearStyle()
 
}
extension IPaStyle {
    public func clearStyle() {
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
open class IPaStyleButton: IPaDesignableButton,IPaStyle {
    override open func awakeFromNib() {
        super.awakeFromNib()
        reloadStyle()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    open func reloadStyle() {
        
    }
    override open func setTitle(_ title: String?, for state: UIControl.State) {
        self.clearStyle()
        super.setTitle(title, for: state)
        self.reloadStyle()
    }
    override open func setImage(_ image: UIImage?, for state: UIControl.State) {
        self.clearStyle()
        super.setImage(image, for: state)
        self.reloadStyle()
    }
}
