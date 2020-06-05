//
//  IPaDesignableTextView.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
//@IBDesignable
open class IPaDesignableTextView: UITextView,IPaDesignable,IPaDesignableShadow,IPaDesignableTextInset {
    open var cornerMask:CAShapeLayer?
    @IBInspectable open var cornerRadius:CGFloat {
        get {
            return self.getCornerRadius()
        }
        set {
            self.setCornerRadius(newValue)
        }
    }
    @IBInspectable open var borderWidth:CGFloat {
        get {
            return self.getBorderWidth()
        }
        set {
            self.setBorderWidth(newValue)
        }
    }
    @IBInspectable open var borderColor:UIColor? {
        get {
            return self.getBorderColor()
        }
        set {
            self.setBorderColor(newValue)
        }
    }

    @IBInspectable open var shadowCornerRadius: CGFloat = 0 {
        didSet {
            self.setShadowCornerRadius(shadowCornerRadius)
        }
    }
    @IBInspectable open var shadowColor:UIColor? {
        didSet {
            self.setShadowColor(shadowColor)
        }
    }
    @IBInspectable open var shadowRadius:CGFloat {
        get {
            return self.getShadowRadius()
        }
        set {
            self.setShadowRadius(newValue)
        }
    }
    @IBInspectable open var shadowOffset:CGSize {
        get {
            return self.getShadowOffset()
        }
        set {
            self.setShadowOffset(newValue)
        }
    }
    @IBInspectable open var shadowOpacity:CGFloat {
        get {
            return self.getShadowOpacity()
        }
        set {
            self.setShadowOpacity(newValue)
        }
    }
    open var shadowPath:CGPath? {
        get {
            return self.getShadowPath()
        }
        set {
            self.setShadowPath(newValue)
        }
    }
    override open var bounds: CGRect {
        didSet {
            self.updateShadowPath()
        }
    }
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
        
        textChangedObserver = NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: self, queue: nil, using: {
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
        var attrs:[NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor:self.placeholderColor]
        if let font = self.font {
            attrs[NSAttributedString.Key.font] = font
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
    open func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.doRoundCorners(corners: corners, radius: radius)
    }
    open func setHtmlContent(_ content:String,encoding:String.Encoding = .utf8,replacePtToPx:Bool = true) {
        var content = replacePtToPx ? IPaDesignableTextView.replaceCSSPtToPx(with: content) : content
            content += "<style>img { max-width:\(self.bounds.size.width - self.leftInset - self.rightInset)px; height: auto !important; } </style>"
            
            
            if let data = content.data(using: encoding) ,let attributedText = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil) {
                self.attributedText = attributedText
                
            }
        }
}
