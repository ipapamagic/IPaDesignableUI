//
//  IPaDesignableWebView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/1/2.
//

import UIKit
import WebKit
import IPaLog
open class IPaDesignableWebView: WKWebView ,IPaDesignable,IPaDesignableShadow,IPaDesignableCanBeInnerScrollView {
    
    public var targetScrollView: UIScrollView {
        get {
            return self.scrollView
        }
    }
    open var cornerMask:CAShapeLayer?
    @IBInspectable open var simultaneouslyOtherGesture: Bool = false
    @IBInspectable open var shadowSpread: CGFloat = 0{
        didSet {
            self.updateShadowPath()
        }
    }
    override open var bounds: CGRect {
        didSet {
            self.updateShadowPath()
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
        let source = "window.addEventListener(\"load\", function () {window.webkit.messageHandlers.windowLoaded.postMessage({});}, false); "
        
        //UserScript object
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        
        //fit content size script
        let metaSource = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width initial-scale=1'); document.getElementsByTagName('head')[0].appendChild(meta);"
        //Content Controller object
        let controller = self.configuration.userContentController
        
        controller.addUserScript(script)
        
        //Add message handler reference
        controller.add(self, name: "windowLoaded")
        
        let metaScript = WKUserScript(source: metaSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        controller.addUserScript(metaScript)
        
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
    public func loadHTMLString(_ string: String, baseURL: URL?,replacePtToPx:Bool) -> WKNavigation? {
        var content = string
        if replacePtToPx {
            content = IPaDesignableWebView.replaceCSSPtToPx(with: string)
        }
        return super.loadHTMLString(content, baseURL: baseURL)
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
