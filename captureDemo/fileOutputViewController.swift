//
//  fileOutputViewController.swift
//  captureDemo
//
//  Created by 区块国际－yin on 2017/3/21.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit

class fileOutputViewController: UIViewController,captureSessionCoordinatorDelegate {

    @IBOutlet weak var recordButton: UIBarButtonItem!
    var captureSessionCoordinator: fileOutputCoordinator?
    var recording: Bool = false
    var dismissing: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        captureSessionCoordinator = fileOutputCoordinator()
        captureSessionCoordinator?.setDelegate(capDelegate: self, queue: DispatchQueue(label: "fileOutputCoordinator"))
        confiureCamper()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    ///  关闭当前视图
    @IBAction func closeCameral(_ sender: Any) {
        if recording {
            dismissing = true
        } else {
            stopPipelineAndDismiss()
        }
    }
    ///  开始记录 与停止记录
    @IBAction func recording(_ sender: Any) {
        if recording {
            captureSessionCoordinator?.stopRecording()
        } else {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        recordButton.isEnabled = false
        recordButton.title = "Stop"
        captureSessionCoordinator?.startRecording()
        recording = true
    }
    
    func confiureCamper() {
        let cameraViewlayer = captureSessionCoordinator?.previewLayerSetting()
        cameraViewlayer?.frame = view.bounds
        view.layer.insertSublayer(cameraViewlayer!, at: 0)
        captureSessionCoordinator?.startRunning()
        
    }
    func stopPipelineAndDismiss() {
        captureSessionCoordinator?.stopRunning()
        dismiss(animated: true, completion: nil)
        dismissing = false
    }
    func coordinatorDidBeginRecording(coordinator: CaptureSessionCoordinator) {
        recordButton.isEnabled = true
    }
    func didFinishRecording(coordinator: CaptureSessionCoordinator, url: URL) {
        UIApplication.shared.isIdleTimerDisabled = false
        recordButton.title = "Record"
        recording = false
        let fm = YfileManager()
        fm.copFileToCameraRoll(fileUrl: url)
        if dismissing {
            stopPipelineAndDismiss()
        }
    }

}
