//
//  TabViewControllerTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/14
//  custom header comment

import Foundation
import UIKit

/**
 UIViewController 확인
 구현한 CustomTabController 적용
 */
class TabControllerTestVC: UIViewController {
    
    override func viewDidLoad() {
        // storyboard에서 TabBarContoller를 추가하거나
        // 상단 메뉴 editor - embaded in - Tab Bar Controller를 통해 구현
        // tab을 추가할 경우 storyboard에서 relationship segue를 통해 연결하거나 코드로 추가 가능
        // 다른 storyboard와 연결한 경우 해당 storyboard ViewConroller에 TabBarItem을 추가해서 설정해야 문구 및 아이콘 반영 가능
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: "Test", image: nil, tag: 3)
        tabBarController?.viewControllers?.append(vc)
        
        tabBarController?.delegate = self
    }
}

extension TabControllerTestVC: UITabBarControllerDelegate {
    // tab이 선택되었을 때. 재선택 시에도 호출
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        NSLog("didSelect \(viewController)")
    }
    
    // 선택 제한
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        NSLog("shouldSelect \(viewController)")
        
//        if viewController is PopDismissVC {
//            return false
//        }
        return true
    }
}
