//
//  IPaDesignableLabel.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/28.
//
//

import UIKit
import IPaImageTool
//@IBDesignable
open class IPaDesignableLabel: UILabel,IPaDesignable ,IPaDesignableTextInset{
    open var cornerMask:CAShapeLayer?
    @IBInspectable public var bottomInset: CGFloat {
        get {
            return textInsets.bottom
        }
        set {
            textInsets.bottom = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
    @IBInspectable public var leftInset: CGFloat {
        get {
            return textInsets.left
        }
        set {
            textInsets.left = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
    @IBInspectable public var rightInset: CGFloat {
        get {
            return textInsets.right
        }
        set {
            textInsets.right = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
    @IBInspectable public var topInset: CGFloat {
        get {
            return textInsets.top
        }
        set {
            textInsets.top = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
    
    @IBInspectable public var textInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override var intrinsicContentSize: CGSize
    {
        get {
            var size = super.intrinsicContentSize
            size.width += self.textInsets.left + self.textInsets.right
            size.height += self.textInsets.top + self.textInsets.bottom
            return size
        }
    }
    open override func drawText(in rect: CGRect) {
        super.drawText(in:rect.inset(by: self.textInsets))
    }
    
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        let textRect = bounds.inset(by: self.textInsets)
        return super.textRect(forBounds: textRect, limitedToNumberOfLines: numberOfLines)
    }
    open func setHtmlContent(_ content:String,encoding:String.Encoding = .utf8,replacePtToPx:Bool = true) {
        var content = replacePtToPx ? IPaDesignableLabel.replaceCSSPtToPx(with: content) : content
        content += "<style>img { max-width:\(self.bounds.size.width - self.textInsets.left - self.textInsets.right)px; height: auto !important; } </style>"
        
        
        if let data = content.data(using: encoding) ,let attributedText = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil) {
            //fit image to content .... css not work ,need to do it yourself
//            let maxWidth = self.bounds.width
//            let text = NSMutableAttributedString(attributedString: attributedText)
//            text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSMakeRange(0, text.length), options: .init(rawValue: 0), using: { (value, range, stop) in
//                if let attachement = value as? NSTextAttachment {
//                    let image = attachement.image(forBounds: attachement.bounds, textContainer: NSTextContainer(), characterIndex: range.location)!
//                    if image.size.width > maxWidth {
//                        let newImage = image.image(fitWidth: maxWidth)
//                        let newAttribut = NSTextAttachment()
//                        newAttribut.image = newImage
//                        text.addAttribute(NSAttributedString.Key.attachment, value: newAttribut, range: range)
//                    }
//                }
//            })

            self.attributedText = attributedText
            
        }
    }
    
}
