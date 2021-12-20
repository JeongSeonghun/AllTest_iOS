//
//  PhotoManager.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation
import Photos
import UIKit


/// 앨범, 카메라 선택 타입
enum PhotoTakeType {
    /// 앨범
    case album
    /// 카메라
    case camera
}

/**
 이미지를 가져오기 위한 매니저
 NSCameraUsageDescription, NSPhotoLibraryUsageDescription inpo.plist 추가 필요
 */
class PhotoTakeManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var takeImage:((UIImage?)->Void)?
    weak var rootViewController:UIViewController? = nil
    var pickerViewController: UIImagePickerController?
    
    func show(viewController:UIViewController, type: PhotoTakeType, callback:@escaping (UIImage?)->Void)  {
        takeImage = callback
        rootViewController = viewController
        switch (type) {
        case .album:
            showAlbum()
            break
        case .camera:
            showCamera()
            break
        }
    }
    
    /// 카메라 연동
    private func showCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera), let rootCtr = rootViewController else {
            return
        }
        
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        if cameraAuthorizationStatus == .authorized {
            let ctr = UIImagePickerController()
            ctr.sourceType = .camera
            ctr.delegate = self
            rootCtr.present(ctr, animated: true, completion: nil)
        }
    }
    
    /// 갤러리 표시
    private func showAlbum() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary), let rootCtr = rootViewController else {
            return
        }
        
        let albumStatus = PHPhotoLibrary.authorizationStatus()
        if albumStatus == .authorized {
            self.pickerViewController = UIImagePickerController()
            self.pickerViewController?.sourceType = .photoLibrary
            self.pickerViewController?.delegate = self
            
            rootCtr.present(self.pickerViewController!, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        rootViewController?.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            takeImage?(image)
        } else {
            takeImage?(nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        rootViewController?.dismiss(animated: true, completion: nil)
        takeImage?(nil)
    }
    
}
