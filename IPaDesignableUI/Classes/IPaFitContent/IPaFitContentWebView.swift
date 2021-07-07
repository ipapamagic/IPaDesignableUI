//
//  IPaFitContentWebView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/1/2.
//

import UIKit
import WebKit
@objc public protocol IPaFitContentWebViewContainer {
    func onWebViewContentSizeUpdate(_ webView:IPaFitContentWebView)
}
// IPaWebViewOpenUrlHandler is for WKNavigationDelegate,that will use open url to open link
open class IPaWebViewOpenUrlHandler:NSObject,WKNavigationDelegate {
    public override init() {
        super.init()
    }
    @available(iOS 13.0, *)
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        
        decisionHandler(self.handleWebViewAction(navigationAction), preferences)
    }
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(self.handleWebViewAction(navigationAction))
    }
    private func handleWebViewAction(_ action:WKNavigationAction) -> WKNavigationActionPolicy {
        guard  action.navigationType == .linkActivated else {
            return .allow
        }
        let request = action.request
        guard let url = request.url else {
            return .allow
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        return .cancel
    }
}
extension IPaDesignableScrollView:IPaFitContentWebViewContainer {
    public func onWebViewContentSizeUpdate(_ webView: IPaFitContentWebView) {
        self.layoutIfNeeded()
    }
}
extension IPaDesignableTableView:IPaFitContentWebViewContainer {
    public func onWebViewContentSizeUpdate(_ webView: IPaFitContentWebView) {
        self.headerViewFitContent()
        self.footerViewFitContent()
    }
    
}
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
    @IBOutlet public var fitContentWebViewContainer:IPaFitContentWebViewContainer?
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
    override func initialJSScript() {
        super.initialJSScript()
    
        self.scrollView.isScrollEnabled = false
        self.scrollView.bounces = false
        self.scrollView.alwaysBounceHorizontal = false
        self.scrollView.alwaysBounceVertical = false
        
        
        let resizeSource = "document.body.addEventListener( 'resize', incrementCounter); function incrementCounter() {window.webkit.messageHandlers.sizeNotification.postMessage({height: document.body.scrollHeight});};"
        
        //UserScript object

        let resizeScript = WKUserScript(source: resizeSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        //Content Controller object
        let controller = self.configuration.userContentController
        
        controller.addUserScript(resizeScript)
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

    override open func onWindowLoaded() {
        self.evaluateJavaScript("window.webkit.messageHandlers.sizeNotification.postMessage({justLoaded:true,height: document.body.scrollHeight});") { (result, error) in
            
        }
    }
    override public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        super.userContentController(userContentController, didReceive: message)
        guard message.name == "sizeNotification", let responseDict = message.body as? [String:Any],
            let height = responseDict["height"] as? CGFloat else {
                return
                
        }
        self.contentHeight = height
        self.fitContentWebViewContainer?.onWebViewContentSizeUpdate(self)
    }
}

