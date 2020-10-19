//
//  CameraController.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import AVFoundation
import Photos
import UIKit

final class CameraController {
    
    private weak var controller: UIViewController?
    private weak var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
        
    init(controller: UIViewController, delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        self.controller = controller
        self.delegate = delegate
    }
    
    func selectSourceAlert() {
        guard let controller = self.controller else {
            return
        }
        
        let alert = UIAlertController(title: "Please select a source", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ -> Void in
            self.askForCameraPermission()
        })
        alert.addAction(UIAlertAction(title: "Gallery", style: .default) { _ -> Void in
            self.askForGalleryPermission()
        })
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        controller.present(alert, animated: true, completion: nil)
    }
    
    private func askForCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            openImageSource(.camera)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [weak self] granted in
                if granted {
                    self?.openImageSource(.camera)
                }
            })
        default:
            // TBA in prod app: show info about access not granted, redirect to settings
            break
        }
    }
    
    private func askForGalleryPermission() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            openImageSource(.photoLibrary)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                if status == .authorized {
                    self?.openImageSource(.photoLibrary)
                }
            }
        default:
            // TBA in prod app: show info about access not granted, redirect to settings
            break
        }
    }
    
    private func openImageSource(_ type: UIImagePickerController.SourceType) {
        DispatchQueue.main.async { [weak self] in
            guard UIImagePickerController.isSourceTypeAvailable(type) else {
                return
            }
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self?.delegate
            imagePicker.sourceType = type
            imagePicker.allowsEditing = false
            
            guard let controller = self?.controller else {
                return
            }
            
            imagePicker.modalPresentationStyle = .overFullScreen
            controller.present(imagePicker, animated: true, completion: nil)
        }
    }

}
