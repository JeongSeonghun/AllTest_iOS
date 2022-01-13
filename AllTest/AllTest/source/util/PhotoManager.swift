//
//  PhotoManager.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation
import Photos
import UIKit
import PhotosUI

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
 
 NSPhotoLibraryAddUsageDescription : 라이브러리 추가
 NSPhotoLibraryUsageDescription : read/write
 */
class PhotoTakeManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var takeImage:((UIImage?)->Void)?
    weak var rootViewController:UIViewController? = nil
    var pickerViewController: UIImagePickerController?
    var changed:(() -> Void)?
    
    /**
     카메라, 사진/앨범 화면 표시
     권한 먼저 체크하고 호출(권한 없을 경우 아무 동작 없음)
     */
    func show(viewController:UIViewController, type: PhotoTakeType, useLimited: Bool = false, callback:@escaping (UIImage?)->Void)  {
        takeImage = callback
        rootViewController = viewController
        switch (type) {
        case .album:
            showAlbum(isWithLimited: useLimited)
            break
        case .camera:
            showCamera()
            break
        }
    }
    
    /// 사진 및 앨범 선택 옵션 추가(iOS 14 대응)
    func showWithPH(viewController:UIViewController, type: PhotoTakeType, useLimited: Bool = false, callback:@escaping (UIImage?)->Void)  {
        takeImage = callback
        rootViewController = viewController
        switch (type) {
        case .album:
            if #available(iOS 14, *) {
                showAlbumPH(isWithLimited: true)
            } else {
                showAlbum(isWithLimited: true)
            }
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
        
        if cameraAuthState() == .authorized { // 권한 체크
            let ctr = UIImagePickerController()
            ctr.sourceType = .camera
            ctr.delegate = self
            rootCtr.present(ctr, animated: true, completion: nil)
        }
    }
    
    /// 갤러리 표시
    private func showAlbum(isWithLimited: Bool = false) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary), let rootCtr = rootViewController else {
            return
        }

        if albumAuthState() == .authorized { // 권한 체크
            self.pickerViewController = UIImagePickerController()
            self.pickerViewController?.sourceType = .photoLibrary
            self.pickerViewController?.delegate = self
            
            rootCtr.present(self.pickerViewController!, animated: true, completion: nil)
        }
        
    }
    
    /**
     PHPickerViewController를 사용한 갤러리 표시
     */
    @available(iOS 14,*)
    private func showAlbumPH(isWithLimited: Bool = false) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary), let rootCtr = rootViewController else {
            return
        }
        
        if albumAuthState() == .authorized || albumAuthState() == .limited { // 권한 체크
            // PhotosUI 추가해야 사용 가능
            var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
//            configuration.selectionLimit = 3 // default 1
            configuration.filter = .images
//            configuration.filter = .any(of: [.livePhotos, .images])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            
            rootCtr.present(picker, animated: true, completion: nil)
        }
    }
    
    func getPHFetchAsset() -> PHFetchResult<PHAsset> {
        let fetchOptions = PHFetchOptions()
        return PHAsset.fetchAssets(with: fetchOptions)
    }
    
    func getPHImage(asset: PHAsset, thumbnailSize: CGSize, handler: @escaping (UIImage) -> Void) {
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        PHImageManager().requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: requestOptions) { (image, info) in
            guard let image = image else { return }
            handler(image)
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

// MARK: - PHPickerViewController PHPickerViewControllerDelegate
@available(iOS 14, *)
extension PhotoTakeManager: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: false, completion: nil)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let img = image as? UIImage {
                    DispatchQueue.main.async {
                        self.takeImage?(img)
                    }
                }
            }
        }
    }
}

// MARK: - PHPhotoLibraryChangeObserver
@available(iOS 14, *)
extension PhotoTakeManager: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async {
            self.changed?()
        }
    }
}

// MARK: - Permission
extension PhotoTakeManager {
    /**
     카메라 권한 상태
     authorized: 허용
     denied: 거절
     */
    func cameraAuthState() -> AVAuthorizationStatus {
        let cameraMediaType = AVMediaType.video
        return AVCaptureDevice.authorizationStatus(for: cameraMediaType)
    }
    
    /**
     사진 및 앨범 권한 상태
     authorized: 허용
     denied: 거절
     limited: 선택 허용 (iOS 14에서 추가됨.)
     */
    func albumAuthState(isWithLimited: Bool = false) -> PHAuthorizationStatus {
        let albumStatus: PHAuthorizationStatus
        if #available(iOS 14, *) {
            if isWithLimited {
                albumStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            } else {
                albumStatus = PHPhotoLibrary.authorizationStatus(for: .addOnly)
            }
        } else {
            albumStatus = PHPhotoLibrary.authorizationStatus()
        }
        return albumStatus
    }
    
    /**
     카메라 권한 확인 및 요청
     */
    func checkCameraPermission(callback: @escaping (Bool) -> Void) {
        // 권한체크 및 요청. 권한 요청 팝업은 최초 요청시에만 표시.
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            DispatchQueue.main.async {
                if granted {
                    NSLog("camera permission ok")
                    // 권한 허용 상태
                    callback(true)
                } else {
                    // 권한 거부 상태
                    NSLog("camera permission deny")
                    callback(false)
                }
            }
            
        }
    }
    
    /**
     사진 및 앨범 권한 확인 및 요청
     authorized: 허용
     denied: 거절
     limited: 선택 허용 (iOS 14에서 추가됨)
     */
    func checkAlbumPermission(isWithLimited: Bool = false, callback: @escaping (PHAuthorizationStatus) -> Void) {
        // 권한 요청 팝업은 최초 요청시에만 표시. 이후는 callback만 호출
        if #available(iOS 14, *) {
            // iOS14 사진 선택 옵션 추가
            // 권한 팝업을 사진 선택 옵션 없이 기존처럼 사용할 경우 addOnly사용
            // addOnly 사용할 경우 NSPhotoLibraryAddUsageDescription 추가 필요
            // limited 인경우 앱 재실행 시 후 한번 선택 변경 팝업 자동으로 표시 (info.plist에 PHPhotoLibraryPreventAutomaticLimitedAccessAlert YES로 할 경우 자동으로 팝업 표시 안됨.)
            PHPhotoLibrary.requestAuthorization(for: isWithLimited ? .readWrite : .addOnly) { (state) in
                DispatchQueue.main.async {
                    NSLog("album permission \(state)")
                    callback(state)
                }
            }
        } else {
            // iOS 14에서 해당 함수를 호출 할 경우 사진 선택 옵션이 추가된 권한 팝업이 표시되나 해당 버튼을 눌러도 authorized로만 callback 실행됨
            PHPhotoLibrary.requestAuthorization { (state) in
                DispatchQueue.main.async {
                    NSLog("album permission \(state)")
                    callback(state)
                }
            }
        }
    }
    
    /**
     사용 이미지 선택 변경 화면 표시
     */
    func showLimitedChangePopup(_ vc: UIViewController, changed:(()->Void)? = nil) {
        // PhotosUI 추가해야 presentLimitedLibraryPicker 호출 가능. 선택 수정
        // PHPhotoLibraryChangeObserver register해서 변화 확인
        if #available(iOS 14, *) {
            PHPhotoLibrary.shared().register(self)
            self.changed = changed
            PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: vc)
        }
    }
}
