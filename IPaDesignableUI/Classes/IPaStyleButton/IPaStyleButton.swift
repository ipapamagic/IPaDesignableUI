//
//  IPaStyleButton.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2018/11/22.
//

import UIKit

open class IPaButtonStyler:NSObject {
    
    open func clearStyle(_ button:UIButton) {
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    open func reloadStyle(_ button:UIButton) {
        
    }
}

open class IPaStyleButton: IPaDesignableButton {
    @IBOutlet open var styler:IPaButtonStyler? {
        didSet {
            self.reloadStyle()
        }
    }
    open override var frame: CGRect {
        didSet {
            self.reloadStyle()
        }
    }
    open func reloadStyle() {
        styler?.reloadStyle(self)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        //can not get correct frame size , so make a timer to update style
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.reloadStyle()
        }
        
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override open func setTitle(_ title: String?, for state: UIControl.State) {
        styler?.clearStyle(self)
        super.setTitle(title, for: state)
        styler?.reloadStyle(self)
    }
    override open func setImage(_ image: UIImage?, for state: UIControl.State) {
        styler?.clearStyle(self)
        super.setImage(image, for: state)
        styler?.reloadStyle(self)
    }
}
