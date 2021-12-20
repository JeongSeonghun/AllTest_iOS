//
//  KeyboardTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/09
//  custom header comment

import Foundation
import UIKit
import IQKeyboardManagerSwift

/**
 키보드 UITextFiel 가리는 현상 해결
 IQKeyboardManagerSwift cocoapods 라이브러리 추가
 pod 'IQKeyboardManagerSwift'
 */
class KeyboardTestVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        // 모든 화면에 적용할 경우 AppDelegate에 구현
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = false
    }
}
