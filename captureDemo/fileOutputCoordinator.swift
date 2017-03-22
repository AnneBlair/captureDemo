//
//  fileOutputCoordinator.swift
//  captureDemo
//
//  Created by 区块国际－yin on 2017/3/22.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit
import AVFoundation

class fileOutputCoordinator: CaptureSessionCoordinator,AVCaptureFileOutputRecordingDelegate {
    
    var movieFileOutput: AVCaptureMovieFileOutput?
    
    override init() {
        super.init()
        movieFileOutput = AVCaptureMovieFileOutput()
        _ = addOutput(output: movieFileOutput!, capSession: captureSession!)
    }
    override func startRecording() {
        let fm = YfileManager()
        let tempUrl = fm.tempFileUrl()
        movieFileOutput?.startRecording(toOutputFileURL: tempUrl, recordingDelegate: self)
    }
    override func stopRecording() {
        movieFileOutput?.stopRecording()
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        delegate?.didFinishRecording(coordinator: self, url: outputFileURL)
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        delegate?.coordinatorDidBeginRecording(coordinator: self)
    }
}
