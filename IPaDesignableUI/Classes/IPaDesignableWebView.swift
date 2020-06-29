//
//  IPaDesignableWebView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/1/2.
//

import UIKit
import WebKit
import IPaLog
open class IPaDesignableWebView: WKWebView ,IPaDesignable,IPaDesignableShadow {
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
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        self.initialJSScript()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialJSScript()
    }
    deinit {
            configuration.userContentController.removeScriptMessageHandler(forName: "windowLoaded")
    //        removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: &observerContext)
    }
    func initialJSScript() {
        let source = "window.onload=function () {window.webkit.messageHandlers.windowLoaded.postMessage({});};"
        
        //UserScript object
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
    
        //Content Controller object
        let controller = self.configuration.userContentController
        
        controller.addUserScript(script)
       
        //Add message handler reference
        controller.add(self, name: "windowLoaded")
        
        
        
    }
    open func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.doRoundCorners(corners: corners, radius: radius)
    }
    open override func load(_ request: URLRequest) -> WKNavigation? {
        if let method = request.httpMethod, method.lowercased() == "post" {
            post(request)
            return nil
        }
        return super.load(request)
    }
    open func post(_ request:URLRequest,encoding: String.Encoding = .utf8) {
        guard let bodyData = request.httpBody,let bodyString = String(data: bodyData, encoding: encoding),let urlString = request.url?.absoluteString else {
            return
        }
        let bodyParams = (bodyString as NSString).components(separatedBy: "&")
        var params = [String]()
        for param in bodyParams {
            let data = (param as NSString).components(separatedBy:"=")
            guard data.count == 2 else {
                continue
            }
            params.append("\"\(data[0])\":\"\(data[1])\"")
        }
        let paramsString = params.joined(separator: ",")
        let postSource = """
            function post(url, params) {
                var method = "post";
                var form = document.createElement("form");
                form.setAttribute("method", method);
                form.setAttribute("action", url);

                for(var key in params) {
                    if(params.hasOwnProperty(key)) {
                        var hiddenField = document.createElement("input");
                        hiddenField.setAttribute("type", "hidden");
                        hiddenField.setAttribute("name", key);
                        hiddenField.setAttribute("value", params[key]);
                        form.appendChild(hiddenField);
                    }
                }
                document.body.appendChild(form);
                form.submit();
            }
            post('\(urlString)',{\(paramsString)});
            """
        self.evaluateJavaScript(postSource) { (result, error) in
            if let error = error {
                IPaLog("IPaDesignableWebView - post error: \(error)")
            }
        }
    }
    open func onWindowLoaded() {
        
    }
    
}
extension IPaDesignableWebView:WKScriptMessageHandler
{
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == "windowLoaded" else {
            return
        }
        self.onWindowLoaded()
    }
}
