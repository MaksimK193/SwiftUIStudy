//
//  CamViewController.swift
//  SwiftUIStudy
//
//  Created by USER on 29.11.2023.
//

import SwiftUI
import UIKit
import AVFoundation
import YandexMobileMetrica

protocol CamViewControllerDelegate: AnyObject {
    func takePhoto(image: UIImage)
    func close()
}

final class CamViewController: UIViewController {
    private var cameraService = CameraService()
    weak var delegate: CamViewControllerDelegate?
    
    private lazy var captureImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 36
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(captureImage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraService.delegate = self
        checkPermissions()
        setupPreviewLayer()
        setupUI()
        YMMYandexMetrica.reportEvent("CamViewScreen opened")
    }
    
    private func setupPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: cameraService.captureSession) as AVCaptureVideoPreviewLayer
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }
    
    private func setupUI() {
        view.addSubview(captureImageButton)
        
        NSLayoutConstraint.activate([
            captureImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureImageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            captureImageButton.widthAnchor.constraint(equalToConstant: 72),
            captureImageButton.heightAnchor.constraint(equalTo: captureImageButton.widthAnchor),
        ])
    }
    
    @objc private func captureImage(_ sender: UIButton?) {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        cameraService.photoOutput.capturePhoto(with: photoSettings, delegate: cameraService)
    }
}

extension CamViewController {
    private func checkPermissions() {
        let cameraAuthStatus =  AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch cameraAuthStatus {
        case .authorized:
            return
        case .denied:
            abort()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { authorized in
                if !authorized {
                    abort()
                }
            }
        case .restricted:
            abort()
        @unknown default:
            fatalError()
        }
    }
}

extension CamViewController: CameraServiceDelegate {
    func setPhoto(image: UIImage) {
        delegate?.takePhoto(image: image)
    }
    
    func close() {
        delegate?.close()
    }
}

struct CameraViewController: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var image: UIImage
    
    func updateUIViewController(_ uiViewController: CamViewController, context: Context) {
        
    }
    
    public typealias UIViewControllerType = CamViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraViewController>) -> CamViewController {
        let viewController = CamViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func makeCoordinator() -> Coordinator {
        return CameraViewController.Coordinator(parent1: self)
    }
    
    class Coordinator: NSObject, CamViewControllerDelegate, UINavigationControllerDelegate {
        func close() {
            self.parent.presentationMode.wrappedValue.dismiss()
        }
        
        func takePhoto(image: UIImage) {
            self.parent.image = image
        }
        
        var parent: CameraViewController
        
        init(parent1: CameraViewController) {
            parent = parent1
        }
    }
}
