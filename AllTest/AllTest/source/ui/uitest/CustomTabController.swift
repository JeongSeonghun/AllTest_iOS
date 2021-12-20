//
//  CusomTabController.swift
//  AllTest
//  
//  Created by jsh on 2021/09/14
//  custom header comment

import Foundation
import UIKit

/**
 TabControllerTestVC 테스트 custom UITabBarController
 */
class CustomTabController: UITabBarController {
    
    override func viewDidLoad() {
        NSLog("\(#file.split(separator: "/").last ?? "") viewDidLoad")
        
        // tabBar 상단, 배경 색상 커스텀
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .gray
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // tabBar 높이 변경
        tabBar.frame.size.height = 80
        tabBar.frame.origin.y = view.frame.height - 80
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NSLog("\(#file.split(separator: "/").last ?? "") viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        NSLog("\(#file.split(separator: "/").last ?? "") viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        NSLog("\(#file.split(separator: "/").last ?? "") viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        NSLog("\(#file.split(separator: "/").last ?? "") viewDidDisappear")
    }
    
}
