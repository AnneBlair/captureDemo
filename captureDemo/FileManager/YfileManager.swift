//
//  fileManager.swift
//  captureDemo
//
//  Created by 区块国际－yin on 2017/3/22.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit
import AssetsLibrary

class YfileManager: NSObject {

    func tempFileUrl() -> URL {
        var path: String = ""
        let fm = FileManager.default
        var i: Int = 0
        while path.isEmpty || fm.fileExists(atPath: path) {
            path = NSTemporaryDirectory() + "output\(i.description).mov"
            i += 1
        }
        return URL(fileURLWithPath: path)
    }
        
    func copFileToCameraRoll(fileUrl: URL) {
        let library = ALAssetsLibrary()
        if !library.videoAtPathIs(compatibleWithSavedPhotosAlbum: fileUrl) {
            printLogDebug("video error")
        }
        library.writeVideoAtPath(toSavedPhotosAlbum: fileUrl) { (url, error) in
            if (error != nil) {
                printLogDebug("error: \(error?.localizedDescription)")
            } else if url == nil {
                printLogDebug("url is empty")
            }
        }
    }
}
