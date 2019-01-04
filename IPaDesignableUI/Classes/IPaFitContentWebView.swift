//
//  IPaFitContentWebView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/1/2.
//

import UIKit
import WebKit
open class IPaFitContentWebView: IPaDesignableWebView {
    fileprivate var scrollViewObserver:Any?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        self.initFitContent()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initFitContent()
    }
    fileprivate func initFitContent() {
        
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        self.configuration.userContentController.addUserScript(userScript)
        
        scrollViewObserver = self.scrollView.observe(\UIScrollView.contentSize, changeHandler: { scrollView, change in
            self.invalidateIntrinsicContentSize()
            if let superview = self.superview {
                superview.setNeedsLayout()
                superview.layoutIfNeeded()
            
            }
        })
    }
    deinit {
        self.scrollViewObserver = nil
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override open var intrinsicContentSize: CGSize {
        if self.scrollView.isScrollEnabled {
            return super.intrinsicContentSize
        }
        return self.scrollView.contentSize
    }
    
}
