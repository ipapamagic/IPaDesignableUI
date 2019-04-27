//
//  IPaImageURLView.swift
//  IPaImageURLLoader
//
//  Created by IPa Chen on 2015/6/16.
//  Copyright (c) 2015年 AMagicStudio. All rights reserved.
//

import Foundation
import UIKit
import IPaLog
import IPaDownloadManager
@objc open class IPaImageURLView : IPaDesignableImageView {
    fileprivate var _imageURL:String?
    fileprivate var _highlightedImageURL:String?

    @objc open var imageURL:String? {
        get {
            return _imageURL
        }
        set {
            setImageURL(newValue, defaultImage: nil)
        }
    }
    @objc open var highlightedImageURL:String? {
        get {
            return _highlightedImageURL
        }
        set {
            setHighlightedImageURL(newValue, defaultImage: nil)
        }
    }
    deinit {
    }
    
    @objc open func setImageURL(_ imageURL:String?,defaultImage:UIImage?) {
        
        _imageURL = imageURL
        self.image = defaultImage
        if let imageURLString = imageURL , let imageUrl = URL(string: imageURLString) {
            _ = IPaDownloadManager.shared.download(from: imageUrl, complete: { (result) in
                switch(result) {
                case .success(let url):
                    do {
                        let data = try Data(contentsOf: url)
                        if  let image = UIImage(data: data) {
                            
                            DispatchQueue.main.async(execute: {
                                self.image = image
                            })
                            
                        }
                    }
                    catch (let error) {
                        IPaLog(error.localizedDescription)
                    }
                case .failure(let error):
                    IPaLog(error.localizedDescription)
                }
            })
        }
    }
    @objc open func setHighlightedImageURL(_ imageURL:String?,defaultImage:UIImage?) {
        self.highlightedImage = defaultImage
        if let imageURLString = imageURL , let imageUrl = URL(string: imageURLString) {
            _ = IPaDownloadManager.shared.download(from: imageUrl) { (result) in
                switch(result) {
                case .success(let url):
                    if let image = UIImage(contentsOfFile: url.absoluteString) {
                        DispatchQueue.main.async(execute: {
                            self.highlightedImage = image
                        })
                    }
                    
                case .failure( _):
                    break
                }
            }
        }
    }
    
}
