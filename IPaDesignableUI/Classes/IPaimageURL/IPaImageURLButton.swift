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
import IPaFileCache
@objc open class IPaImageURLButton : IPaDesignableButton,IPaDesignableFitImage {
    private var _imageUrl:URL?
    private var _backgroundImageUrl:URL?
    var ratioConstraint:NSLayoutConstraint?
    var downloadImageOperation:Operation?
    var downloadBGImageOperation:Operation? 
    var ratioConstraintPrority:Float = 250
    @IBInspectable open var backgroundImageRatioConstraintPrority:Float {
        get {
            return ratioConstraintPrority
        }
        set {
            ratioConstraintPrority = newValue
        }
    }
    @objc open var imageUrl:URL? {
        get {
            return _imageUrl
        }
        set {
            setImageUrl(newValue, defaultImage: nil)
        }
    }
    @objc open var backgroundImageUrl:URL? {
        get {
            return _backgroundImageUrl
        }
        set {
            setBackgroundImageUrl(newValue, defaultImage: nil)
        }
    }
    @objc open var imageURLString:String? {
        get {
            return _imageUrl?.absoluteString
        }
        set {
            if let urlString = newValue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string:urlString) {
                setImageUrl(url, defaultImage: nil)
            }
            else {
                setImageUrl(nil, defaultImage: nil)
            }
        }
    }
    @objc open var backgroundImageURLString:String? {
        get {
            return _backgroundImageUrl?.absoluteString
        }
        set {
            if let urlString = newValue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string:urlString) {
                setBackgroundImageUrl(url, defaultImage: nil)
            }
            else {
                setBackgroundImageUrl(nil, defaultImage: nil)
            }
        }
    }
    @objc open func setImageUrl(_ imageUrl:URL?,defaultImage:UIImage?) {
        self.setImage(defaultImage, for: .normal)
        if let imageUrl = imageUrl {
            if let data = IPaFileCache.shared.cacheFileData(for: imageUrl), let image = UIImage(data: data) {
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
                        let newUrl = IPaFileCache.shared.moveToCache(for: imageUrl, from: url)
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
    @objc open func setBackgroundImageUrl(_ imageUrl:URL?,defaultImage:UIImage?) {
        self.setBackgroundImage(defaultImage, for: .normal)
        if let imageUrl = imageUrl {
            if let data = IPaFileCache.shared.cacheFileData(for: imageUrl), let image = UIImage(data: data) {
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
                        let newUrl = IPaFileCache.shared.moveToCache(for: imageUrl, from: url)
                        let data = try Data(contentsOf: newUrl)
                        if  let image = UIImage(data: data)                             {
                            
                            DispatchQueue.main.async(execute: {
                                self.computeImageRatioConstraint(image)
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

