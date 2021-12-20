//
//  ToastTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/16
//  custom header comment

import Foundation
import UIKit
import Toast_Swift

/**
 Toast library 테스트
 cocoapods 추가 필요
 pod 'Toast-Swift', '~> 5.0.1'
 */
class ToastTestVC: UIViewController {
    
    @IBAction func clickShowToast() {
        self.view.makeToast("test toast")
    }
}
