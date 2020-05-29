//
//  IPaFitContentWebView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/1/2.
//

import UIKit
import WebKit
//private var observerContext = 0
open class IPaFitContentWebView: IPaDesignableWebView {
    fileprivate var contentHeight:CGFloat = 0 {
        didSet {
            guard self.heightConstraint.constant != contentHeight else{
                return
            }
            self.heightConstraint.constant = contentHeight
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
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
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        self.initFitContent()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initFitContent()
    }
    fileprivate func initFitContent() {
        
        
        let source = "window.onload=function () {window.webkit.messageHandlers.sizeNotification.postMessage({justLoaded:true,height: document.body.scrollHeight});};"
        let source2 = "document.body.addEventListener( 'resize', incrementCounter); function incrementCounter() {window.webkit.messageHandlers.sizeNotification.postMessage({height: document.body.scrollHeight});};"
        let source3 = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width initial-scale=1'); document.getElementsByTagName('head')[0].appendChild(meta);"
        
        
        //UserScript object
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let script2 = WKUserScript(source: source2, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let script3 = WKUserScript(source: source3, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        //Content Controller object
        let controller = self.configuration.userContentController
        
        controller.addUserScript(script)
        controller.addUserScript(script2)
        controller.addUserScript(script3)
        //Add message handler reference
        controller.add(self, name: "sizeNotification")
        
        
//        addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: &observerContext)
        
    }
    deinit {
        configuration.userContentController.removeScriptMessageHandler(forName: "sizeNotification")
//        removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: &observerContext)
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override open var intrinsicContentSize: CGSize {
        return CGSize(width:self.scrollView.contentSize.width,height:contentHeight)
        
    }
//    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if context == &observerContext {
//            if let _ = change?[.newKey] as? Double {
//
//                guard self.estimatedProgress > 0.5 else { return }
//                let javascriptString = "" +
//                    "var body = document.body;" +
//                    "var html = document.documentElement;" +
//                    "Math.max(" +
//                    "   body.scrollHeight," +
//                    "   body.offsetHeight," +
//                    "   html.clientHeight," +
//                    "   html.offsetHeight" +
//                ");"
//
//                self.evaluateJavaScript(javascriptString) { (result, error) in
//                    let contentHeight = result as? CGFloat ?? 0.0
//
//                    if contentHeight != self.contentHeight {
//                        self.contentHeight = contentHeight
//
//                    }
//                }
//
//            }
//
//        } else {
//            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//        }
//    }
    public func loadHTMLString(_ string: String, baseURL: URL?,replacePtToPx:Bool) -> WKNavigation? {
        var content = string
        if replacePtToPx {
            content = IPaFitContentWebView.replaceCSSPtToPx(with: string)
        }
        return super.loadHTMLString(content, baseURL: baseURL)
    }
}
extension IPaFitContentWebView:WKScriptMessageHandler
{
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let responseDict = message.body as? [String:Any],
            let height = responseDict["height"] as? CGFloat else {
                return
                
        }
        self.contentHeight = height
        
    }
}
