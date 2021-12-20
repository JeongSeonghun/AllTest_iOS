//
//  SceneDelegate.swift
//  AllTest
//
//  Created by jsh on 2021/08/20.
//

import UIKit

@available(iOS 13.0, *)
/**
 SceneDelegate
 SceneDelegate를 사용하고 싶지 않은 경우 아래 내용을 제거
 - info.plist에서 Application Scene Manifest 항목 제거
 - AppDelegate에서 configurationForConnecting, didDiscardSceneSessions 제거
 */
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var savedShortCutItem: UIApplicationShortcutItem! // Quick Action 동작 확인용
    
    var backTaskManager = BackgroundTaskManager()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        NSLog("scene willConnectTo")
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // Quick Action
        if let shortItem = connectionOptions.shortcutItem {
            savedShortCutItem = shortItem
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        NSLog("sceneDidDisconnect")
    }

    // Active 상태일 때 호출
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        NSLog("sceneDidBecomeActive")
        if let shortItem = savedShortCutItem {
            _ = QuickActionManager.handleQuickAction(shortcutItem: shortItem)
            savedShortCutItem = nil
        }
    }

    // Inactive 상태가 되기전에 호출
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        NSLog("sceneWillResignActive")
        
        // Quick Action (Dynamic. runtime에 변경 가능) 정의
        let application = UIApplication.shared
        application.shortcutItems = TestContactModel.shared.getFavoriteQuickItems()
    }

    // 앱이 백그라운드에서 포그라운드로 올라올 때 호출(Active상태가 되기 전, 화면보여지기 전)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        NSLog("sceneWillEnterForeground")
    }

    // 앱이 백그라운드에 진입했을 때 호출
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        NSLog("sceneDidEnterBackground")
        
        backTaskManager.scheduleAppRefresh()
        backTaskManager.schduleBackProcess()
    }

    // url scheme을 통해 앱이 호출됐을 때 호출
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        NSLog("url scene open : \(URLContexts)")
        
        guard let url = URLContexts.first?.url else { return }
        let schemeStr = url.scheme
        let host = url.host
        let path = url.path
        let query = url.query
        
        NSLog("url scheme : \(schemeStr ?? ""),\nhost : \(host ?? ""),\npath: \(path),\nquery : \(query ?? "")")
        
        if schemeStr == "alltestapp" {
            
            URLOpeUtil.urlQueryAction(query: query)
            NotificationCenter.default.post(name: NSNotification.Name("TestData"), object: nil)
        }
    }
    
    // MARK: - Quick Action
    // quick action 홈화면 앱 롱클릭 메뉴 클릭 시 호출(iOS13 이상에서만 동작)
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        // 앱 실행 중일 때 호출
        NSLog("quick action performActionFor")
        let handle = QuickActionManager.handleQuickAction(shortcutItem: shortcutItem)
        completionHandler(handle)
    }
}

