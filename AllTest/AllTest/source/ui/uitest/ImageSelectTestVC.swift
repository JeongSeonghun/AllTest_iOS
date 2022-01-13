//
//  ImageSelectTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation
import UIKit
import Photos

/**
 Camera, Album 활용 테스트
 */
// NSCameraUsageDescription, NSPhotoLibraryUsageDescription inpo.plist 추가 필요
class ImageSelectTestVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    let photoManger = PhotoTakeManager()
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func clickCameraButton() {
        
        if photoManger.cameraAuthState() == .denied {
            // 권한 팝업에서 거절을 눌러도 callback 실행이 되므로 앞에서 거절 상태 확인
            TestAlert.show(self, msg: "MSG_NEED_CAMERA_PERMISSION".localized(), fstAction: {
                Util.openSetting()
            })
            return
        }
        
        photoManger.checkCameraPermission { granted in
            if granted {
                self.photoManger.show(viewController: self, type: .camera, callback: { (image) in
                    if let image = image {
                        self.imageView.image = image
                    }
                })
            }
        }
    }
    
    @IBAction func clickAlbumButton() {
        if photoManger.albumAuthState() == .denied {
            // 권한 팝업에서 거절을 눌러도 callback 실행이 되므로 앞에서 거절 상태 확인
            TestAlert.show(self, msg: "MSG_NEED_PICTURE_PERMISSION".localized(), fstAction: {
                Util.openSetting()
            })
            return
        }
        
        let useLimited = false // 사진 및 앨범 iOS14 사진 선택 권한 테스트 시 true 사용
        photoManger.checkAlbumPermission(isWithLimited: useLimited) { state in
            switch state {
            case .authorized:
                NSLog("permission authorized")
                self.photoManger.show(viewController: self, type: .album, useLimited: useLimited) { image in
                    if let image = image {
                        self.imageView.image = image
                    }
                }
            case .limited:
                NSLog("permission limited")
                // 선택 항목 표시를 위해 직접 구현 필요.
                self.getCanAccessImages()
                // 임시
                self.photoManger.showWithPH(viewController: self, type: .album, useLimited: useLimited) { image in
                    if let image = image {
                        self.imageView.image = image
                    }
                }
            default:
                break
            }
        }
    }
    
    var canAccessImages: [UIImage] = []
    func getCanAccessImages() {
        let thumbnailSize = CGSize(width: 100, height: 100)
        canAccessImages = []
        
        let result = photoManger.getPHFetchAsset()
        
        NSLog("check image count: \(result.count)")
        
        result.enumerateObjects { asset, _, _ in
            self.photoManger.getPHImage(asset: asset, thumbnailSize: thumbnailSize) { image in
                self.canAccessImages.append(image)
//                DispatchQueue.main.async {
//                    self.collectionView.insertItems(at: [IndexPath(item: self.canAccessImages.count - 1, section: 0)])
//                }
            }
        }
        
    }
}
