//
//  PopDismissVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/03
//  custom header comment

import Foundation
import UIKit

class PopDismissVC: UIViewController {
    
    @IBOutlet weak var vcCntLabel: UILabel!
    
    override func viewDidLoad() {
        // 이미 UINavigationController내에 같은 ViewController가 생성된 적 있는 경우 present/push할 때 viewDidLoad호출 안됨.
        NSLog("\(#file.split(separator: "/").last ?? "") viewDidLoad")
        
        // 다크모드 동작 여부 결정. os13이상 부터 별다른 설정 없으면 다크모드가 적용됨
        // 사용하지 않을 경우
        // 1. plist -> 모든 화면 적용
        // User Interface Style(UIUserInterfaceStyle) - Light
        // 2. ViewController -> 해당 화면 적용
        // self.overrideUserInterfaceStyle = .light
        // 3. AppDelegate 또는 SceneDelegate -> 모든 화면 적용
        // window?.overrideUserInterfaceStyle = .light
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        _ = Util.getTopViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NSLog("\(#file.split(separator: "/").last ?? "") viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        NSLog("\(#file.split(separator: "/").last ?? "") viewDidAppear")
        vcCntLabel.text = "\(navigationController?.viewControllers.count ?? 0)"
        _ = Util.getTopViewController()
    }
    override func viewWillDisappear(_ animated: Bool) {
        NSLog("\(#file.split(separator: "/").last ?? "") viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        NSLog("\(#file.split(separator: "/").last ?? "") viewDidDisappear")
    }
    
    @IBAction func clickPop() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickPopToVC() {
        if let vcList = navigationController?.viewControllers {
            for vc in vcList {
                if vc is PresentPushTestVC {
                    navigationController?.popToViewController(vc, animated: true)
                    break
                }
            }
        }
    }
    
    @IBAction func clickPopRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func clickDismiss() {
        dismiss(animated: true) {
            NSLog("dismiss")
            _ = Util.getTopViewController()
        }
    }
    
    @IBAction func clickSelfPresent() {
        if let vc = storyboard?.instantiateInitialViewController() {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func clickSelefPush() {
        if let vc = storyboard?.instantiateInitialViewController() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
