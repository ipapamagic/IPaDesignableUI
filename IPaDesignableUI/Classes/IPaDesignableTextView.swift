//
//  IPaDesignableTextView.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
//@IBDesignable
open class IPaDesignableTextView: UITextView {
    @IBInspectable open var caretHeight:CGFloat = 0
    @IBInspectable open var placeholder:String = ""
        {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable open var placeholderColor:UIColor = UIColor.darkGray
        {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable public var bottomInset: CGFloat {
        get {
            return textContainerInset.bottom
        }
        set {
            textContainerInset.bottom = newValue
        }
    }
    @IBInspectable public var leftInset: CGFloat {
        get {
            return textContainerInset.left
        }
        set {
            textContainerInset.left = newValue
        }
    }
    @IBInspectable public var rightInset: CGFloat {
        get {
            return textContainerInset.right
        }
        set {
            textContainerInset.right = newValue
        }
    }
    @IBInspectable public var topInset: CGFloat {
        get {
            return textContainerInset.top
        }
        set {
            textContainerInset.top = newValue
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
    @IBInspectable open var shadowColor: UIColor? {
        didSet {
            self.layer.shadowColor = shadowColor?.cgColor
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
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var textChangedObserver:NSObjectProtocol?
    override open func awakeFromNib() {
        super.awakeFromNib()
        addTextChangeObserver()
    }
    func addTextChangeObserver() {
        
        textChangedObserver = NotificationCenter.default.addObserver(forName:  NSNotification.Name.UITextViewTextDidChange, object: self, queue: nil, using: {
            noti in
            self.setNeedsDisplay()
        })
        
    }
    deinit {
        if let textChangedObserver = textChangedObserver {
            NotificationCenter.default.removeObserver(textChangedObserver)
        }
        //        removeObserver(self, forKeyPath: "font")
        //        removeObserver(self, forKeyPath: "text")
        //        removeObserver(self, forKeyPath: "placeholder")
        //        removeObserver(self, forKeyPath: "placeholderColor")
        //        removeObserver(self, forKeyPath: "textContainerInset")
    }
    override open func draw(_ rect: CGRect) {
        //return if hasText
        if self.hasText {
            return
        }
        
        // attr
        var attrs:[NSAttributedStringKey:Any] = [NSAttributedStringKey.foregroundColor:self.placeholderColor]
        if let font = self.font {
            attrs[NSAttributedStringKey.font] = font
        }
        
        var placeHolderRect = rect
        //draw text
        placeHolderRect.origin.x = textContainerInset.left + textContainer.lineFragmentPadding
        placeHolderRect.origin.y = textContainerInset.top
        placeHolderRect.size.width = self.bounds.width  - textContainerInset.left - textContainerInset.right - textContainer.lineFragmentPadding - textContainer.lineFragmentPadding
        placeHolderRect.size.height = self.bounds.height - textContainerInset.top - textContainerInset.bottom
        (self.placeholder as NSString).draw(in: placeHolderRect, withAttributes: attrs)
        
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
    override open func caretRect(for position: UITextPosition) -> CGRect {
        var superRect = super.caretRect(for:position)
        if caretHeight <= 0 {
            return superRect
        }
        superRect.size.height = caretHeight
        // "descender" is expressed as a negative value,
        // so to add its height you must subtract its value
        
        return superRect
//        if caretHeight == 0 {
//            return superRect
//        }
//        superRect.size.height = caretHeight
//        return superRect
    }
}
