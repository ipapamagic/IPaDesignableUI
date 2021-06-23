//
//  IPaDesignableTextView.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
//@IBDesignable
open class IPaDesignableTextView: UITextView,IPaDesignable,IPaDesignableShadow,IPaDesignableTextInset,IPaDesignableCanBeInnerScrollView {
    @IBInspectable open var simultaneouslyOtherGesture: Bool = false
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
    @IBInspectable open var shadowColor:UIColor? {
        didSet {
            self.setShadowColor(shadowColor)
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
    @IBInspectable open var shadowBlur: CGFloat {
        get {
            return self.getShadowBlur()
        }
        set {
            self.setShadowBlur(newValue)
        }
    }
    @IBInspectable open var shadowSpread: CGFloat = 0{
        didSet {
            self.updateShadowPath()
        }
    }
    override open var bounds: CGRect {
        didSet {
            self.updateShadowPath()
            self.setNeedsDisplay()
        }
    }
    @IBInspectable open var caretHeight:CGFloat = 0
    @IBInspectable open var placeholder:String?
        {
        get {
            return placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
            self.setNeedsDisplay()
        }
        
    }
    @IBInspectable open var placeholderColor:UIColor
        {
        get {
            return placeholderLabel.textColor
        }
        set {
            placeholderLabel.textColor = newValue
        }
    }
    var placeholderLeadingConstraint:NSLayoutConstraint?
    var placeholderTopConstraint:NSLayoutConstraint?
    var placeholderTrailingConstraint:NSLayoutConstraint?
    var placeholderBottomConstraint:NSLayoutConstraint?
    lazy var placeholderLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        placeholderLeadingConstraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: textContainerInset.left + textContainer.lineFragmentPadding)
        self.addConstraint(placeholderLeadingConstraint!)
        placeholderTopConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: textContainerInset.top)
        self.addConstraint(placeholderTopConstraint!)
        placeholderBottomConstraint = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .bottom, multiplier: 1, constant: textContainerInset.bottom)
        self.addConstraint(placeholderBottomConstraint!)
        setNeedsDisplay()
        return label
    }()
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
            placeholderLabel.isHidden = true
            return
        }
        placeholderLabel.isHidden = false
        
        placeholderLeadingConstraint?.constant = textContainerInset.left + textContainer.lineFragmentPadding
        placeholderTopConstraint?.constant = textContainerInset.top
        placeholderBottomConstraint?.constant = textContainerInset.bottom
        placeholderTrailingConstraint?.constant = textContainerInset.right
        
//        // attr
//        var attrs:[NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor:self.placeholderColor]
//        if let font = self.font {
//            attrs[NSAttributedString.Key.font] = font
//        }
//
//        var placeHolderRect = rect
//        //draw text
//        placeHolderRect.origin.x = textContainerInset.left + textContainer.lineFragmentPadding
//        placeHolderRect.origin.y = textContainerInset.top
//        placeHolderRect.size.width = self.bounds.width  - textContainerInset.left - textContainerInset.right - textContainer.lineFragmentPadding - textContainer.lineFragmentPadding
//        placeHolderRect.size.height = self.bounds.height - textContainerInset.top - textContainerInset.bottom
//        (self.placeholder as NSString).draw(at: placeHolderRect.origin, withAttributes: attrs)
//
    }
//    override open func layoutSubviews() {
//        super.layoutSubviews()
//        self.setNeedsDisplay()
//    }
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
extension IPaDesignableTextView:UIGestureRecognizerDelegate
{
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return simultaneouslyOtherGesture
    }
}
