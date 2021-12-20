//
//  AppDelegate.swift
//  AllTest
//
//  Created by jsh on 2021/08/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // 없을 경우 main이 안보일 수 있어 추가(SceneDelegate 추가로인해 target 13미만으로 했을 경우 발생)
    var window: UIWindow?
    
    var savedShortCutItem: UIApplicationShortcutItem! // Quick Action 동작 확인용
    
    var backTaskManager = BackgroundTaskManager() // background task test

    // 앱 싷행 직후 호출
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NSLog("didFinishLaunchingWithOptions")
        
        // 디버깅 차단. (rooting, rooting 우회, 무결성 등 보안 관련은 추가 및 변경되는 경우들이 있기 때문에 주기적 확인이 필요함. 비용을 내고 전문 업체 프레임워크를 쓰는 방법도 있음)
        guard AntiDebug.run() else {
            return false
        }
        
        backTaskManager.readyBackgroundTask()
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // backgroudn fetch로 iOS13 미만에서만 호출. iOS13 이상은 BackgroundTasks Framework 사용

        NSLog("performFetchWithCompletionHandler")
        backTaskManager.updateFetch(completionHandler: completionHandler)
    }
    
    // 앱이 종료되기 직전에 호출
    func applicationWillTerminate(_ application: UIApplication) {
        NSLog("applicationWillTerminate")
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        NSLog("applicationDidReceiveMemoryWarning")
    }
    
    // MARK: - SceneDelegate에서 처리
    
    // url scheme을 통해 앱이 호출됐을 때 호출
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // 주의 SceneDelegate를 사용할 경우 SceneDelegate openURLContexts 에서 수신됨
        NSLog("url open : \(url)")
        if url.scheme == "alltestapp" {
            URLOpeUtil.urlQueryAction(query: url.query)
        }
        return true
    }
    
    // 앱이 Active 상태일 때 호출
    func applicationDidBecomeActive(_ application: UIApplication) {
        // 주의 SceneDelegate를 사용할 경우 SceneDelegate sceneDidBecomeActive 에서 수신됨
        NSLog("applicationDidBecomeActive")
        
        // Quick Action
        if let shourtItem = savedShortCutItem {
            _ = QuickActionManager.handleQuickAction(shortcutItem: shourtItem)
            savedShortCutItem = nil
        }
    }
    
    // 앱이 Inactive 상태가 되기전에 호출
    func applicationWillResignActive(_ application: UIApplication) {
        // 주의 SceneDelegate를 사용할 경우 SceneDelegate sceneWillResignActive 에서 수신됨
        NSLog("applicationWillResignActive")
        
        if #available(iOS 13, *) {
            // quick action(dynamic) 정의
            application.shortcutItems = TestContactModel.shared.getFavoriteQuickItems()
        }
    }
    
    // 앱이 백그라운드에서 포그라운드로 올라올 때 호출(Active상태가 되기 전, 화면보여지기 전)
    func applicationWillEnterForeground(_ application: UIApplication) {
        // 주의 SceneDelegate를 사용할 경우 SceneDelegate sceneWillEnterForeground 에서 수신됨
        NSLog("applicationWillEnterForeground")
    }
    
    // 앱이 백그라운드에 진입했을 때 호출
    func applicationDidEnterBackground(_ application: UIApplication) {
        // 주의 SceneDelegate를 사용할 경우 SceneDelegate sceneDidEnterBackground 에서 수신됨
        NSLog("applicationDidEnterBackground")
        
        if #available(iOS 13.0, *) {
            backTaskManager.scheduleAppRefresh()
            backTaskManager.schduleBackProcess()
        }
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.

        NSLog("configurationForConnecting")
        // Quick Action
        if let shortItem = options.shortcutItem {
            savedShortCutItem = shortItem
        }

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        NSLog("didDiscardSceneSessions")
    }

    // MARK: - Quick Action
    // quick action 홈화면 앱 롱클릭 메뉴 클릭 시 호출(iOS13 이상에서만 동작)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        // 앱 실행 중일 때 호출
        // 주의 SceneDelegate를 사용할 경우 SceneDelegate performActionFor 에서 수신됨
        NSLog("quick action application performActionFor")
        let handle = QuickActionManager.handleQuickAction(shortcutItem: shortcutItem)
        completionHandler(handle)
    }
    
}

