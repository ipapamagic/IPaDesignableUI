//
//  IPaFitContentUIWebView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/2/25.
//

import UIKit

public class IPaFitContentUIWebView: IPaDesignableUIWebView {
    fileprivate var scrollViewObserver:Any?
    fileprivate var contentHeight:CGFloat = 0 {
        didSet {
            guard let superview = self.superview ,self.heightConstraint.constant != contentHeight else{
                return
            }
            
            
            self.invalidateIntrinsicContentSize()
            self.heightConstraint.constant = contentHeight
            superview.setNeedsLayout()
            superview.layoutIfNeeded()
        }
    }
    lazy var heightConstraint:NSLayoutConstraint = {
        let constraint = self.heightAnchor.constraint(equalToConstant: self.contentHeight)
        constraint.priority = UILayoutPriority(rawValue: 999)
        constraint.isActive = true
        
        return constraint
    }()
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initFitContent()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initFitContent()
    }
    fileprivate func initFitContent() {
        scrollViewObserver = self.scrollView.observe(\UIScrollView.contentSize, changeHandler: { scrollView, change in
            self.contentHeight = self.scrollView.contentSize.height
            
        })
    }
    deinit {
        self.scrollViewObserver = nil
    }
    override open var intrinsicContentSize: CGSize {
        return CGSize(width:self.scrollView.contentSize.width , height: self.contentHeight)
    }
}
