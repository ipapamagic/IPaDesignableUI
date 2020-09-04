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
    fileprivate var _imageUrl:URL?
    fileprivate var _highlightedImageUrl:URL?
    var downloadOperation:Operation?
    @objc open var imageUrl:URL? {
        get {
            return _imageUrl
        }
        set {
            setImageUrl(newValue, defaultImage: nil)
        }
    }
    @objc open var highlightedImageUrl:URL? {
        get {
            return _highlightedImageUrl
        }
        set {
            setHighlightedImageUrl(newValue, defaultImage: nil)
        }
    }
    @objc open var imageURLString:String? {
        get {
            return _imageUrl?.absoluteString
        }
        set {
            if let urlString = newValue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string: urlString) {
                setImageUrl(url, defaultImage: nil)
            }
            else {
                setImageUrl(nil, defaultImage: nil)
            }
        }
    }
    @objc open var highlightedImageURLString:String? {
        get {
            return _highlightedImageUrl?.absoluteString
        }
        set {
            if let urlString = newValue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string: urlString) {
                setHighlightedImageUrl(url, defaultImage: nil)
            }
        }
    }
    @available(*, unavailable, renamed: "setImageUrl")
    @objc open func setImageURL(_ imageURL:String?,defaultImage:UIImage?) {
    }
    @objc open func setImageUrl(_ imageUrl:URL?,defaultImage:UIImage?) {
        _imageUrl = imageUrl
        self.image = defaultImage
        if let imageUrl = imageUrl {
            if let data = IPaImageURLCache.shared.cacheFile(with: imageUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async(execute: {
                    self.image = image
                })
                return
            }
            downloadOperation = IPaDownloadManager.shared.download(from: imageUrl, complete: { (result) in
                self.downloadOperation = nil
                switch(result) {
                case .success(let (_,url)):
                    do {
                        let newUrl = IPaImageURLCache.shared.saveCache(with: imageUrl, from: url)
                        let data = try Data(contentsOf: newUrl)
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
    @available(*, unavailable, renamed: "setHighlightedImageUrl")
    @objc open func setHighlightedImageURL(_ imageURL:String?,defaultImage:UIImage?) {
    }
    @objc open func setHighlightedImageUrl(_ imageUrl:URL?,defaultImage:UIImage?) {
        self.highlightedImage = defaultImage
        if let imageUrl = imageUrl {
            if let data = IPaImageURLCache.shared.cacheFile(with: imageUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async(execute: {
                    self.highlightedImage = image
                })
                return
            }
            _ = IPaDownloadManager.shared.download(from: imageUrl) { (result) in
                switch(result) {
                case .success(let (_,url)):
                    let newUrl = IPaImageURLCache.shared.saveCache(with: imageUrl, from: url)
                    if let image = UIImage(contentsOfFile: newUrl.absoluteString) {
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
