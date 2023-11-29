//
//  CamerService.swift
//  SwiftUIStudy
//
//  Created by USER on 29.11.2023.
//

import UIKit
import AVFoundation

protocol CameraServiceDelegate: AnyObject {
    func setPhoto(image: UIImage)
    func close()
}

final class CameraService: NSObject, ObservableObject {
    private var captureDevice: AVCaptureDevice?
    private var backCamera: AVCaptureDevice?
    
    private var backInput: AVCaptureInput!
    private let cameraQueue = DispatchQueue(label: "com.CapturingModelQueue")
    
    weak var delegate: CameraServiceDelegate?
    
    let captureSession = AVCaptureSession()
    let photoOutput = AVCapturePhotoOutput()
    
    override init() {
        super.init()
        setupAndStartCaptureSession()
    }
    
    private func getCurrentDevice() -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInDualWideCamera,
                                                                              .builtInLiDARDepthCamera, .builtInTelephotoCamera,
                                                                              .builtInTripleCamera, .builtInTrueDepthCamera,
                                                                              .builtInUltraWideCamera, .builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .back)
        guard let device = discoverySession.devices.first else { return nil }
        
        return device
    }
    
    private func setupAndStartCaptureSession() {
        cameraQueue.async { [weak self] in
            self?.captureSession.beginConfiguration()
            
            if let canSetSessionPreset = self?.captureSession.canSetSessionPreset(.photo), canSetSessionPreset {
                self?.captureSession.sessionPreset = .photo
            }
            self?.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            
            self?.setupInputs()
            self?.setupOutput()
            
            self?.captureSession.commitConfiguration()
            self?.captureSession.startRunning()
        }
    }
    
    private func setupInputs() {
        backCamera = getCurrentDevice()
        
        guard let backCamera = backCamera else { return }
        
        do {
            backInput = try AVCaptureDeviceInput(device: backCamera)
            guard captureSession.canAddInput(backInput) else { return }
        } catch {
            fatalError("could not connect camera")
        }
        
        captureDevice = backCamera
        
        captureSession.addInput(backInput)
    }
    
    private func setupOutput() {
        guard captureSession.canAddOutput(photoOutput) else { return }
        
        photoOutput.isHighResolutionCaptureEnabled = true
        photoOutput.maxPhotoQualityPrioritization = .balanced
        
        captureSession.addOutput(photoOutput)
    }
}

extension CameraService: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            print("Fail to capture photo: \(String(describing: error))")
            return
        }
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
        guard let image = UIImage(data: imageData) else {
            return
        }

        self.delegate?.close()
        
        DispatchQueue.main.async {
            self.delegate?.setPhoto(image: image)
        }
    }
}
