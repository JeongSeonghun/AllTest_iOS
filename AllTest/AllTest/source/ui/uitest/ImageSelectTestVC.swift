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
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            DispatchQueue.main.async {
                if granted {
                    self.photoManger.show(viewController: self, type: .camera, callback: { (image) in
                        if let image = image {
                            self.imageView.image = image
                        }
                    })
                    
                } else {
                    // 권한 요청 팝업은 최초 요청시에만 표시
                }
            }
            
        }
    }
    
    @IBAction func clickAlbumButton() {
        let albumState = PHPhotoLibrary.authorizationStatus()
        if albumState == .denied {
            // 권한 요청 팝업은 최초 요청시에만 표시
            
        } else {
            PHPhotoLibrary.requestAuthorization { (state) in
                DispatchQueue.main.async {
                    if state == .authorized {
                        self.photoManger.show(viewController: self, type: .album) { (image) in
                            if let image = image {
                                self.imageView.image = image
                            }
                        }
                    } else {
                        
                    }
                }
                
            }
        }
    }
}
