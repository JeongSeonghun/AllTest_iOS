//
//  SideMenuTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/09
//  custom header comment

import Foundation
import UIKit
import SideMenu

/**
 SideMenu 라이브러리 cocoapods 추가 필요
 pod 'SideMenu'
 */
class SideMenuTestVC: UIViewController {
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "actionIconAlarm"), style: .plain, target: self, action: #selector(clcikRightSideMenuButton(sender:)))
        
        initSlideSidelMenu()
    }
    
    // MARK: - storyboard를 이용해 연결
    @IBAction func clcikRightSideMenuButton(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "rightSideMenu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sideMenuNavigationController = segue.destination as? SideMenuNavigationController {
            sideMenuNavigationController.settings = makeSettings()
            return
        }
    }
    
    func makeSettings() -> SideMenuSettings {
        var setting = SideMenuSettings()
        setting.presentationStyle = SideMenuPresentationStyle.menuSlideIn
        setting.presentationStyle.presentingEndAlpha = CGFloat(0.5)
        setting.statusBarEndAlpha = 0
        return setting
    }
    
    // MARK: - 코드로 구현
    @IBAction func clickSlideMenuButton() {
        let viewController = UIStoryboard(name: "CustomSideVC", bundle: nil).instantiateViewController(withIdentifier: "CustomSideVC")
        let menu = SideMenuNavigationController(rootViewController: viewController)
        
        menu.sideMenuDelegate = self
        
        present(menu, animated: true, completion: nil)
    }
    
    // MARK: - gesture 테스트
    func initSlideSidelMenu() {
        let viewController = UIStoryboard(name: "CustomSideVC", bundle: nil).instantiateViewController(withIdentifier: "CustomSideVC")
        
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: viewController)
        // swipe pop 기능 제거 안할 경우. navigation push로 들어온 화면에서는 좌측 메뉴 제스처 동작이 먹히지 않고 swipe pop이 동작함
        // viewWillAppear, viewWillDisappear pop기능 활성화 결정
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
//        SideMenuManager.default.rightMenuNavigationController = leftMenuNavigationController

        // AppDelegate에 넣어서 공통적으로 전체화면에 사용하고 싶은 경우
//        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
//        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        // 해당 화면에서만 사용하고 싶은 경우
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)

        leftMenuNavigationController.statusBarEndAlpha = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}

extension SideMenuTestVC: SideMenuNavigationControllerDelegate {
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        NSLog("sideMenuDidAppear")
    }
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        NSLog("sideMenuWillAppear")
    }
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        NSLog("sideMenuDidDisappear")
    }
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        NSLog("sideMenuWillDisappear")
    }
}
