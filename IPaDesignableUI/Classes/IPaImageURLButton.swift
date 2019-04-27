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
@objc open class IPaImageURLButton : IPaDesignableButton {
    private var _imageURL:String?
    private var _backgroundImageURL:String?
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
            _ = IPaDownloadManager.shared.download(from: imageUrl) { (result) in
                switch(result) {
                case .success(let url):
                    do {
                        let data = try Data(contentsOf: url)
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
            _ = IPaDownloadManager.shared.download(from: imageUrl) { (result) in
                switch(result) {
                case .success(let url):
                    do {
                        let data = try Data(contentsOf: url)
                        if  let image = UIImage(data: data)                             {
                            DispatchQueue.main.async(execute: {
                                self.setBackgroundImage(image, for: .normal)
                            })
                            
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

