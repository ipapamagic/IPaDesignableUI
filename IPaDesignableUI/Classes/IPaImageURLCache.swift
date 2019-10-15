//
//  IPaImageURLCache.swift
//  Bolts
//
//  Created by IPa Chen on 2019/8/30.
//

import UIKit
import IPaSecurity
class IPaImageURLCache: NSObject {
    static let shared = IPaImageURLCache()
    lazy var cachePath:String = {
        var cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        cachePath = (cachePath as NSString).appendingPathComponent("IPaImageURLCache")
        let fileMgr = FileManager.default
        if !fileMgr.fileExists(atPath: cachePath) {
            var error:NSError?
            do {
                try fileMgr.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
            } catch let error1 as NSError {
                error = error1
            }
            if let error = error {
                print(error)
            }
        }
        return cachePath
    }()
    func cacheFile(with url:URL) -> Data?  {
        let path = (cachePath as NSString ).appendingPathComponent(url.absoluteString.md5String ?? url.absoluteString) as String
        if !FileManager.default.fileExists(atPath: path) {
            return nil
        }
        
        return try? Data(contentsOf: URL(fileURLWithPath:path))
    }
    func saveCache(with url:URL,from fileUrl:URL) -> URL {
        let path = (cachePath as NSString ).appendingPathComponent(url.absoluteString.md5String ?? url.absoluteString) as String
        let pathUrl = URL(fileURLWithPath: path)
        try? FileManager.default.moveItem(at: fileUrl, to: pathUrl)
        return pathUrl
    }
}
