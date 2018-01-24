//
//  CameraController.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-23.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
    
    lazy var captureButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "capture_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        view.addTarget(self, action: #selector(captureAction), for: .touchUpInside)
        return view
    }()
    
    lazy var dismissButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "right_arrow_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        view.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        
        setupHUD()
    }
    
    fileprivate func setupHUD() {
        view.addSubview(captureButton)
        captureButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topPadding: 0, leftPadding: 0, bottomPadding: 24, rightPadding: 0, width: 80, height: 80)
        captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topPadding: 12, leftPadding: 0, bottomPadding: 0, rightPadding: 12, width: 50, height: 50)
    }
    
    fileprivate func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch let error {
            print("Error while adding capture input: ", error)
        }
        
        let output = AVCapturePhotoOutput()
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    @objc
    func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func captureAction() {
        print("Capture photo...")
    }
}
