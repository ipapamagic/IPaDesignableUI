//
//  IPaDesignableWebView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/1/2.
//

import UIKit
import WebKit
open class IPaDesignableWebView: WKWebView {
    @IBInspectable open var isScrollEnabled: Bool {
        get {
            return self.scrollView.isScrollEnabled
        }
        set  {
            self.scrollView.isScrollEnabled = newValue
        }
    }
    @IBInspectable open var bounces: Bool {
        get {
            return self.scrollView.bounces
        }
        set  {
            self.scrollView.bounces = newValue
        }
    }
    override open var bounds: CGRect {
        didSet {
            if self.cornerRadius > 0 && self.shadowColor != nil {
                self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
            }
        }
    }
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
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
    @IBInspectable open var shadowColor: UIColor? {
        didSet {
            if shadowColor != nil {
                self.layer.shadowColor = shadowColor?.cgColor
                self.clipsToBounds = false
                self.layer.masksToBounds = false
                if self.cornerRadius > 0 {
                    self.layer.shouldRasterize = true
                    self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
                }
                
            }
            else {
                self.layer.shadowColor = nil
            }
            
        }
    }
    @IBInspectable open var shadowRadius: CGFloat {
        set {
            self.layer.shadowRadius = newValue
        }
        get {
            return self.layer.shadowRadius
        }
    }
    @IBInspectable open var shadowOffset: CGSize {
        set {
            self.layer.shadowOffset = newValue
        }
        get {
            return self.layer.shadowOffset
        }
    }
    @IBInspectable open var shadowOpacity: CGFloat {
        set {
            self.layer.shadowOpacity = Float(newValue)
        }
        get {
            return CGFloat(self.layer.shadowOpacity)
        }
    }
    open var shadowPath: CGPath? {
        set {
            self.layer.shadowPath = newValue
        }
        get {
            return self.layer.shadowPath
        }
    }
}
