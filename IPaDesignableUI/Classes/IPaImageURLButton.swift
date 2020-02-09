//
//  IPaImageURLButton.swift
//  IPaImageURLLoader
//
//  Created by IPa Chen on 2015/6/16.
//  Copyright (c) 2015年 AMagicStudio. All rights reserved.
//

import Foundation
import UIKit
import IPaDownloadManager
@objc open class IPaImageURLButton : IPaDesignableButton,IPaDesignableFitImage {
    private var _imageURL:String?
    private var _backgroundImageURL:String?
    var ratioConstraint:NSLayoutConstraint?
    var downloadImageOperation:Operation? {
        willSet {
            if let operation = downloadImageOperation,!(operation.isCancelled || operation.isFinished) {
                operation.cancel()
            }
        }
    }
    var downloadBGImageOperation:Operation? {
        willSet {
            if let operation = downloadBGImageOperation,!(operation.isCancelled && operation.isFinished) {
                operation.cancel()
            }
        }
    }
    @objc open var imageURL:String? {
        get {
            return _imageURL
        }
        set {
            setImageURL(newValue, defaultImage: nil)
        }
    }
    @objc open var backgroundImageURL:String? {
        get {
            return _backgroundImageURL
        }
        set {
            setBackgroundImageURL(newValue, defaultImage: nil)
        }
    }
    @objc open func setImageURL(_ imageURL:String?,defaultImage:UIImage?) {
        self.setImage(defaultImage, for: .normal)
        if let imageURLString = imageURL , let imageUrl = URL(string: imageURLString) {
            if let data = IPaImageURLCache.shared.cacheFile(with: imageUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async(execute: {
                    self.setImage(image, for: .normal)
                })
                return
            }
            downloadImageOperation = IPaDownloadManager.shared.download(from: imageUrl) { (result) in
                self.downloadImageOperation = nil
                switch(result) {
                case .success(let (_,url)):
                    do {
                        let newUrl = IPaImageURLCache.shared.saveCache(with: imageUrl, from: url)
                        let data = try Data(contentsOf: newUrl)
                        if  let image = UIImage(data: data) {

                            DispatchQueue.main.async(execute: {
                                self.setImage(image, for: .normal)
                            })
                            
                        }
                    }
                    catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    @objc open func setBackgroundImageURL(_ imageURL:String?,defaultImage:UIImage?) {
        self.setBackgroundImage(defaultImage, for: .normal)
        if let imageURLString = imageURL , let imageUrl = URL(string: imageURLString) {
            if let data = IPaImageURLCache.shared.cacheFile(with: imageUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async(execute: {
                    self.setBackgroundImage(image, for: .normal)
                })
                return
            }
            downloadBGImageOperation = IPaDownloadManager.shared.download(from: imageUrl) { (result) in
                self.downloadBGImageOperation = nil
                switch(result) {
                case .success(let (_,url)):
                    do {
                        let newUrl = IPaImageURLCache.shared.saveCache(with: imageUrl, from: url)
                        let data = try Data(contentsOf: newUrl)
                        if  let image = UIImage(data: data)                             {
                            
                            DispatchQueue.main.async(execute: {
                                self.computeImageRatioConstraint(image,prority: 1000)
                                self.setNeedsLayout()
                                self.setBackgroundImage(image, for: .normal)
                                
                            })
                            
                        }
                        else {
                            self.removeImageRatioConstraint()
                        }
                    }
                    catch let error {
                        print(error)
                    }
                    
                case .failure( _):
                    break
                }
            }
        }
    }
}

