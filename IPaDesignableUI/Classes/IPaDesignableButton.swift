//
//  IPaDesignableButton.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
@IBDesignable
open class IPaDesignableButton: UIButton {
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

}
