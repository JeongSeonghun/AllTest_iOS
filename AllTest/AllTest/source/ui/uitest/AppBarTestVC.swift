//
//  AppBarTestVC.swift
//  AllTest
//  
//  Created by jsh on 2022/01/13
//  custom header comment

import Foundation
import UIKit

/**
 statusBar test
 */
class AppBarTestVC: UIViewController {
    
    var isDark = true
    var isHidden = false
    
    override func viewDidLoad() {
        // info.plist UIViewControllerBasedStatusBarAppearance NO 일때 동작
//        UIApplication.shared.statusBarStyle = .lightContent
//        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
        // info.plist에 UIStatusBarStyle 추가해서 기본 스타일 설정 가능 가능(UIViewControllerBasedStatusBarAppearance YES인 경우 동작 안함)
        
        setBackground()
    }
    
    @IBAction func changeStatusBarColor() {
        isDark = !isDark
        self.setNeedsStatusBarAppearanceUpdate()
        setBackground()
        navigationController?.setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func changeHidden(sw: UISwitch) {
        isHidden = sw.isOn
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func setBackground() {
        if isDark {
            view.backgroundColor = .white
        } else {
            view.backgroundColor = .black
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // statusbar 내용 색상 변경 확인을 위해 배경 색 변경
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .gray
            navigationController?.navigationBar.standardAppearance = appearance
        } else {
            navigationController?.navigationBar.tintColor = .gray
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // statusbar 배경 색 원복
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            navigationController?.navigationBar.standardAppearance = appearance
        } else {
            navigationController?.navigationBar.tintColor = nil
        }
    }
    
    // 시간 및 배터리 정보 등 표시 색상
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // info.plist에 UIViewControllerBasedStatusBarAppearance YES 추가 필요
        // navigation에서 사용 시 NavigationViewController에 childForStatusBarStyle 설정하지 않을 경우 동작 안함.(UITabBarController, UISplitViewController 사용 시에도 동일)
        NSLog("test preferredStatusBarStyle")
        if #available(iOS 13, *) {
            if isDark {
                return .darkContent
            } else {
                return .lightContent
            }
        } else {
            if isDark {
                return .default
            } else {
                return .lightContent
            }
        }
    }
    
    // 시간 및 배터리 정보 등 표시 여부
    override var prefersStatusBarHidden: Bool {
        // navigation에서 사용 시 NavigationViewController에 childForStatusBarHidden 설정하지 않을 경우 동작 안함.(UITabBarController, UISplitViewController 사용 시에도 동일)
        return isHidden
    }
}
