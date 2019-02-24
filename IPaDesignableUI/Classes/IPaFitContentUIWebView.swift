//
//  IPaFitContentUIWebView.swift
//  IPaDesignableUI
//
//  Created by IPa Chen on 2019/2/25.
//

import UIKit

public class IPaFitContentUIWebView: IPaDesignableUIWebView {

    fileprivate var scrollViewObserver:Any?
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
}
